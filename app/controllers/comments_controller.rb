class CommentsController < ApplicationController
  before_action :set_commentable, only: [:create, :destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to :back, notice: 'comment successfully added'
    else
      redirect_to :back, alert: 'unable to add the comment'
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to :back, notice: 'comment deleted'
  end

  private

  def set_commentable
    @commentable = Slide.find(params[:commentable_id]) if params[:commentable_type] == 'Slide'
    @commentable = Lecture.find(params[:commentable_id]) if params[:commentable_type] == 'Lecture'
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
