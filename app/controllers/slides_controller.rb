class SlidesController < ApplicationController
  before_action :set_lecture
  before_action :set_slide, only: [:show, :edit, :update, :destroy]
  # GET /slides
  # GET /slides.json
  def index
    @slides = @lecture.slides.all.order(page_number: :asc)
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
  end

  # GET /slides/new
  # def new
    # @slide = @lecture.slides.new
  # end

  # GET /slides/1/edit
  # def edit
  # end

  # POST /slides
  # POST /slides.json
  def create
    @slide = @lecture.slides.new(slide_params)

    respond_to do |format|
      if @slide.save
        format.html { redirect_to @slide, notice: 'Slide was successfully created.' }
        format.json { render :show, status: :created, location: @slide }
      else
        format.html { render :new }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slides/1
  # PATCH/PUT /slides/1.json
  # def update
    # respond_to do |format|
      # if @slide.update(slide_params)
        # format.html { redirect_to @slide, notice: 'Slide was successfully updated.' }
        # format.json { render :show, status: :ok, location: @slide }
      # else
        # format.html { render :edit }
        # format.json { render json: @slide.errors, status: :unprocessable_entity }
      # end
    # end
  # end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide = @lecture.slides.find(params[:id])
    @slide.destroy
    respond_to do |format|
      format.html { redirect_to slides_url, notice: 'Slide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:lecture_id])
    end

    def set_slide
      @slide = @lecture.slides.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slide_params
      params.require(:slide).permit(:path, :lecture_id)
    end
end
