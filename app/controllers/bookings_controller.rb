class BookingsController < ApplicationController
  before_filter :find_performer
  before_filter :check_recipient_id, only: [:accept]

  CHARGE_FEE_PERCENT = 0.05
  TRANSFER_FEE_PERCENT = 0.05

  def index
    @bookings = @performer.bookings.sort_by(&:created_at)
    @accepted, @pending = @bookings.partition(&:accepted?)
    @completed = @accepted.select(&:past?)
  end

  def create
    # save the stripe details for later (when the performer accepts the booking)
    create_stripe_customer unless current_user.stripe_customer_id

    booking_params = params.require(:booking).permit(:event_date, :cost)
    @booking = @performer.build_booking(booking_params)
    @booking.user = find_user

    if @booking.save
      flash[:notice] = "Your booking has been created, check your profile to see if the performer has accepted."
    else
      flash[:error] = @booking.errors.messages
    end

    redirect_to performer_path(@performer)
  end

  def accept
    booking = Booking.find(params.require(:id))
    chargee = booking.user

    if (customer_id = chargee.stripe_customer_id)
      create_stripe_charge(booking, customer_id)
      transfer_id = transfer_to_performer(booking)
      booking.transfer_id = transfer_id
      booking.accepted = true
      booking.save!
    else
      flash[:error] = "The user that requested this booking doesn't have any payment info associated, please contact support@beathavenapp.com"
    end
    redirect_to performer_bookings_path(@performer)
  end

  def decline
    booking = Booking.find(params.require(:id))
    booking.active = false
    booking.save!

    render nothing: true, status: 200
  end

  private
  def get_stripe_customer
    Stripe::Customer.retrieve(id: current_user.stripe_customer_id)
  end

  def create_stripe_customer
    customer = Stripe::Customer.create(
      card:        params.require(:stripeToken),
      description: params.require(:stripeEmail)
    )
    current_user.stripe_customer_id = customer.id
    current_user.save!
  end

  def create_stripe_charge(booking, chargee_id)
    Stripe::Charge.create(
      amount: charge_amount(booking.cost),
      currency: "usd",
      customer: chargee_id,
      application_fee: charge_fee(booking.cost),
      description: "Booking for #{booking.performer.name} on #{booking.event_date}"
    )
  end

  def transfer_to_performer(booking)
    transfer = Stripe::Transfer.create(
      amount: transfer_amount(booking.cost),
      currency: "usd",
      recipient: booking.performer.recipient_id,
      description: "Booking for #{booking.performer.name} on #{booking.event_date}",
      statement_descriptor: "Booking for #{booking.performer.name} on #{booking.event_date}"
    )
    transfer.id
  end

  def charge_amount(cost)
    (cost * 100).to_i
  end

  def charge_fee(cost)
    ((cost * 100) * CHARGE_FEE_PERCENT).to_i
  end

  def transfer_amount(cost)
    ((cost * 100) * (1 - TRANSFER_FEE_PERCENT)).to_i
  end

  def check_recipient_id
    if @performer.recipient_id.blank?
      flash[:error] = "This performer has no bank info associated, please update your listing"
      redirect_to edit_performer_path(@performer)
    end
  end

  def find_performer
    @performer ||= Performer.find(params.require(:performer_id))
  end

  def find_user
    User.find(params.require(:booking).permit(:user_id)[:user_id])
  end
end
