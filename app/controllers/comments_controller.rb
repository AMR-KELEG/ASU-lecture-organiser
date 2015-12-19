class CommentsController < ApplicationController
  before_action :set_commentable, only: [:create, :destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to @commentable, notice: "comment successfully added" if params[:commentable_type]=='Lecture'
      redirect_to [@commentable.lecture, @commentable], notice: "comment successfully added" if params[:commentable_type]=='Slide'
    else
      redirect_to @commentable, alert: "unable to add the comment" if params[:commentable_type]=='Lecture'
      redirect_to [@commentable.lecture, @commentable], alert: "unable to add the comment" if params[:commentable_type]=='Slide'
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to @commentable, notice: "comment deleted" if params[:commentable_type]=='Lecture'
    redirect_to [@commentable.lecture, @commentable], notice: "comment deleted" if params[:commentable_type]=='Slide'
  end

  private
    def set_commentable
      @commentable = Slide.find(params[:commentable_id]) if params[:commentable_type]=='Slide'
      @commentable = Lecture.find(params[:commentable_id]) if params[:commentable_type]=='Lecture'
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
