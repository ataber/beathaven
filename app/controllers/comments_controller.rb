class CommentsController < ApplicationController
  before_filter :find_booking

  def index
    @comments = @booking.comments
  end

  private
  def find_booking
    @booking ||= Booking.find(params[:booking_id])
  end
end