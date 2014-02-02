class CommentsController < ApplicationController
  def index
    @booking  = Booking.find(params[:booking_id])
    @comments = @booking.comments
  end

  def create
    comment = Comment.create(comments_params)
    respond_to do |format|
      format.json do
        html = render_to_string partial: "comment.html.haml", locals: { comment: comment }
        render json: { html: html }
      end
    end
  end

  private
  def comments_params
    params.require(:comment).permit(:content, :booking_id, :user_id)
  end
end