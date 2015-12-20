class SlidesController < ApplicationController
  before_action :set_lecture
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  def upvote
    @slide = @lecture.slides.find(params[:id])
    @slide.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @slide = @lecture.slides.find(params[:id])
    @slide.downvote_by current_user
    redirect_to :back
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end

  def set_slide
    @slide = @commentable = @lecture.slides.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def slide_params
    params.require(:slide).permit(:path, :lecture_id)
  end
end
