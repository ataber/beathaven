class PerformersController < ApplicationController
  before_action :set_performer, only: [:show, :edit, :update, :destroy]
  before_filter :authorized_to_edit?, only: [:edit, :update, :destroy]

  def index
    scope = Performer.all
    scope = scope.genre_like(params[:genre]) if params[:genre].present?
    scope = scope.name_like(params[:search_text]) if params[:search_text].present?
    @performers = scope.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    if url = @performer.soundcloud_url.presence
      client      = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_ID'])
      @embed_info = client.get('/oembed', :url => url, :maxwidth => "500", :maxheight => "500")
    end
    @booking = @performer.bookings.new
  end

  def new
    @performer = Performer.new
  end

  def edit
  end

  def create
    @performer = Performer.new(performer_params)
    create_stripe_record(@performer)

    respond_to do |format|
      if @performer.save
        format.html { redirect_to @performer, notice: 'Listing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @performer }
      else
        format.html { render action: 'new' }
        format.json { render json: @performer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    update_stripe_record(@performer)

    respond_to do |format|
      if @performer.update(performer_params)
        format.html { redirect_to @performer, notice: 'Listing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @performer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def create_stripe_record(performer)
    recipient = Stripe::Recipient.create(
      name: params.require(:legal_billing_name),
      type: "individual",
      email: params.require(:billing_email),
      bank_account: params.require(:stripeToken)
      )
    performer.recipient_id = recipient.id
  end

  def update_stripe_record(performer)
    recipient = Stripe::Recipient.retrieve(recipient_id)
    recipient.update(
      name: params.require(:legal_billing_name),
      type: "individual",
      email: params.require(:billing_email),
      bank_account: params.require(:stripeToken)
      )
    recipient.save
  end

  def authorized_to_edit?
    if current_user != @performer.user
      flash[:error] = "You are not authorized to edit that listing"
      redirect_to :back
      return
    end
  end

  def set_performer
    @performer = Performer.find(params[:id])
  end

  def performer_params
    params[:performer].permit(:price, :description, :name, :soundcloud_url, :genre, :user_id)
  end
end
