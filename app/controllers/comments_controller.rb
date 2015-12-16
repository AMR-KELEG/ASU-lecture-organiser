class CommentsController < ApplicationController
  before_action :set_slide, only: [:create, :destroy]

  def create
    @comment = @slide.comments.new(comment_params)
    if @comment.save
      redirect_to [@slide.lecture, @slide], notice: "comment successfully added"
    else
      redirect_to [@slide.lecture, @slide], alert: "unable to add the comment"
    end
  end

  def destroy
    @comment = @slide.comments.find(params[:id])
    @comment.destroy
    redirect_to [@slide.lecture, @slide], notice: "comment deleted!"
  end

  private
    def set_slide
      @slide = Slide.find(params[:slide_id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
