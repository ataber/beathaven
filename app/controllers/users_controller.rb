class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params.require(:id))
    @bookings = @user.bookings
    @performers = @user.performers
  end
end
