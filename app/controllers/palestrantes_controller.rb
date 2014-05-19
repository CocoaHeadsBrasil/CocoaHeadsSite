class PalestrantesController < ApplicationController

  before_action :confirm_logged_in, except: [:public]
  before_action :set_palestrante, only: [:show, :edit, :update, :destroy]

  layout :choose_layout

  # GET /palestrantes
  # GET /palestrantes.json
  def index
    @palestrantes = Palestrante.all
  end

  # GET /palestrantes/1
  # GET /palestrantes/1.json
  def show
  end

  # GET /palestrantes/new
  def new
    @palestrante = Palestrante.new
  end

  # GET /palestrantes/1/edit
  def edit
  end

  # POST /palestrantes
  # POST /palestrantes.json
  def create
    @palestrante = Palestrante.new(palestrante_params)

    respond_to do |format|
      if @palestrante.save
        format.html { redirect_to @palestrante, notice: 'Palestrante was successfully created.' }
        format.json { render action: 'show', status: :created, location: @palestrante }
      else
        format.html { render action: 'new' }
        format.json { render json: @palestrante.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /palestrantes/1
  # PATCH/PUT /palestrantes/1.json
  def update
    respond_to do |format|
      if @palestrante.update(palestrante_params)
        format.html { redirect_to @palestrante, notice: 'Palestrante was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @palestrante.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /palestrantes/1
  # DELETE /palestrantes/1.json
  def destroy
    @palestrante.destroy
    respond_to do |format|
      format.html { redirect_to palestrantes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_palestrante
      @palestrante = Palestrante.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def palestrante_params
      params.require(:palestrante).permit(:nome, :email, :website, :twitter, :github, :linkedin, :published, :mini_curriculo)
    end

    def choose_layout
      action_name == "public" ? "internal" : "admin"
    end
end
