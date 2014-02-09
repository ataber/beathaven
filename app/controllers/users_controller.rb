class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.preload(:performers, bookings: :performer).find(params.require(:id))
    @past_bookings, @upcoming_bookings = @user.bookings.partition(&:past?)
    @performers = @user.performers
  end
end
