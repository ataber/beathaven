class BookingsController < ApplicationController
  before_filter :find_performer

  def index
    @bookings = @performer.bookings.sort_by(&:created_at)
    @accepted, @pending = @bookings.partition(&:accepted?)
    @completed = @accepted.select(&:past?)
  end

  def create
    # save the stripe details for later, when the performer accepts the booking
    get_stripe_customer

    @booking = Booking.new(params.require(:booking).permit(:event_date, :cost))
    @booking.performer = @performer
    @booking.user = find_user

    if @booking.save
      flash[:notice] = "Your booking has been created, check your profile to see if the performer has accepted."
    else
      flash[:error] = @booking.errors.messages
    end
    redirect_to performer_path(@performer)
  end

  def accept
    booking = Booking.where(id: params.require(:id)).preload(:user, :performer).first
    user = booking.user

    if (customer_id = user.stripe_customer_id)
      Booking.transaction do
        raise "No recipient ID for #{booking.performer.name}" unless booking.performer.recipient_id
        begin
          Stripe::Charge.create(
            amount:  (booking.cost*100).to_i,
            currency: "usd",
            customer: customer_id
            )
          transfer = Stripe::Transfer.create(
            amount: (booking.cost*100).to_i,
            currency: "usd",
            recipient: booking.performer.recipient_id,
            statement_descriptor: "Booking for #{booking.performer.name} on #{booking.date}"
            )
          booking.transfer_id = transfer.id
          booking.accepted = true
          booking.save!
        rescue Stripe::CardError => e
          flash[:error] = e.message
        end
      end
    else
      flash[:error] = "The user that requested this booking doesn't have any payment info associated"
    end
    redirect_to performer_bookings_path(@performer)
  end

  def decline
    booking = Booking.find(params.require(:id))
    booking.update_attribute(:active, false)
    render nothing: true, status: 200
  end

  private
  def get_stripe_customer
    if (stripe_id = current_user.stripe_customer_id)
      Stripe::Customer.retrieve(id: stripe_id)
    else
      customer = Stripe::Customer.create(
        card:        params.require(:stripeToken),
        description: params.require(:stripeEmail)
        )
      current_user.update_attribute(:stripe_customer_id, customer.id)
    end
  end

  def find_performer
    @performer ||= Performer.find(params.require(:performer_id))
  end

  def find_user
    @user ||= User.find(params.require(:booking).permit(:user_id)[:user_id])
  end
end