class RecipientsController < ApplicationController
  before_filter :set_performer

  attr_accessor :performer

  def show
  end

  def update
    begin
      recipient = @performer.recipient
      stripe_record = recipient.stripe_record
      stripe_record.name = billing_params["legal_billing_name"],
      stripe_record.card = {
        number:    billing_params["card_number"],
        cvc:       billing_params["cvc"],
        exp_month: billing_params["expires_on(2i)"],
        exp_year:  billing_params["expires_on(1i)"],
      }
      stripe_record.save
    rescue Stripe::InvalidRequestError, Stripe::CardError => e
      flash[:error] = e.message
      redirect_to performer_recipient_path(@performer)
      return
    end

    flash[:notice] = "Billing successfully updated"
    redirect_to edit_performer_path(@performer)
  end

  def create
    begin
      recipient = Stripe::Recipient.create(
        name: billing_params["legal_billing_name"],
        type: "individual",
        card: {
          number:    billing_params["card_number"],
          cvc:       billing_params["cvc"],
          exp_month: billing_params["expires_on(2i)"],
          exp_year:  billing_params["expires_on(1i)"],
        }
      )
      @performer.create_recipient(stripe_id: recipient.id)
    rescue Stripe::InvalidRequestError, Stripe::CardError => e
      flash[:error] = e.message
      redirect_to performer_recipient_path(@performer)
      return
    end

    flash[:notice] = "Billing information successfully saved"
    redirect_to edit_performer_path(@performer)
  end

  private
  def set_performer
    self.performer = Performer.find(params.require(:performer_id))
  end
end