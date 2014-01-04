class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end
end
