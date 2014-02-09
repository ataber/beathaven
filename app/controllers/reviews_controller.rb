class ReviewsController < ApplicationController
  def create
    review = Review.new(params.require(:review).permit(:content))
    review.performer_id = params.require(:performer_id)
    review.user_id = params.require(:user_id)
    if review.save
      flash[:notice] = "Review saved"
    else
      flash[:error] = "Error in saving review"
    end
    redirect_to edit_user_path(current_user)
  end
end