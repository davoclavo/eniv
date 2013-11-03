class VinesController < ApplicationController
  before_action :set_vine, only: [:show, :edit, :update, :destroy]

  # GET /vines
  # GET /vines.json
  def index
    @vines = Vine.all
  end

  # GET /vines/1
  # GET /vines/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @vine.attributes}
    end
  end

  # GET /vines/new
  def new
    @vine = Vine.new
  end

  # GET /vines/1/edit
  def edit
  end

  # POST /vines
  # POST /vines.json
  def create
    @vine = Vine.new(vine_params)

    respond_to do |format|
      if @vine.save
        format.html { redirect_to @vine, notice: 'Vine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vine }
      else
        format.html { render action: 'new' }
        format.json { render json: @vine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vines/1
  # PATCH/PUT /vines/1.json
  def update
    respond_to do |format|
      if @vine.update(vine_params)
        format.html { redirect_to @vine, notice: 'Vine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vines/1
  # DELETE /vines/1.json
  def destroy
    @vine.destroy
    respond_to do |format|
      format.html { redirect_to vines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vine
      @vine = Vine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vine_params
      params[:vine]
    end
end
