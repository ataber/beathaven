class UsersController < ApplicationController
  before_filter :find_user, except: [:new, :edit]

  def new
    @user = User.new
  end

  def edit
  end

  def upcoming_events
    @past_bookings = @user.bookings.reject(&:past?)
  end

  def past_events
    @upcoming_bookings = @user.bookings.select(&:past?)
  end

  def performers
    @performers = @user.performers
  end

  private
  def find_user
    @user = User.find(params.require(:user_id))
  end
end
