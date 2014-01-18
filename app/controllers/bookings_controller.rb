class BookingsController < ApplicationController
  before_filter :stripe_credentials

  def create
    # save the stripe details for later, when the performer accepts the booking
    token = params[:stripeToken]
    customer = Stripe::Customer.create(
      :card => token,
      :description => params[:stripeEmail]
      )
    save_stripe_customer_id(user, customer.id)

    @booking   = Booking.new(params[:booking])
    @performer = Performer.find(params[:performer_id])
    @booking.performer = @performer
    if @booking.save
      flash[:notice] = "Your booking has been created, check your profile to see if the performer has accepted."
    else
      flash[:error] = "We were unable to save your booking, please try again later"
    end
    redirect_to performer_path(@performer)
  end

  def accept
    customer_id = get_stripe_customer_id(user)
    Stripe::Charge.create(
      :amount => cost,
      :currency => "usd",
      :customer => customer_id
      )
  end

  private

  def stripe_credentials
    Stripe.api_key = ENV["STRIPE_API_KEY"]
  end
end