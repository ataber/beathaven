class BookingsController < ApplicationController
  before_filter :stripe_credentials, :except => :index
  before_filter :find_performer

  def index
    @bookings = @performer.bookings.sort_by(&:created_at)
    @accepted, @pending = @bookings.partition(&:accepted?)
  end

  def create
    # save the stripe details for later, when the performer accepts the booking
    token = params.require(:stripeToken)
    customer = Stripe::Customer.create(
      :card => token,
      :description => params.require(:stripeEmail)
      )
    save_stripe_customer_id(current_user, customer.id)

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
    booking = Booking.find(params.require(:id))
    user = booking.user
    if customer_id = get_stripe_customer_id(user)
      Stripe::Charge.create(
        :amount => cost,
        :currency => "usd",
        :customer => customer_id
        )
    else
      flash[:error] = "The user that requested this booking doesn't have any payment info associated"
    end
  end

  private
  def find_performer
    @performer ||= Performer.find(params.require(:performer_id))
  end

  def find_user
    @user ||= User.find(params.require(:booking).permit(:user_id)[:user_id])
  end

  def save_stripe_customer_id(user, id)
    user.stripe_customer_id = id
    user.save!
  end

  def get_stripe_customer_id(user)
    if user.stripe_customer_id.present?
      return user.stripe_customer_id
    else
      throw "No Payment Data For This User"
    end
  end

  def stripe_credentials
    Stripe.api_key = ENV["STRIPE_API_KEY"]
  end
end