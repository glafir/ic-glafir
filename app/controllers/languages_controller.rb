class LanguagesController < ApplicationController
  before_action :set_language, only: [:show, :edit, :update, :destroy]

  # GET /languages
  def index
    @languages = Language.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @languages
    respond_with @languages
  end

  # GET /languages/1
  def show
    authorize @language
    respond_with @language
  end

  # GET /languages/new
  def new
    @language = Language.new
    authorize @language
    respond_with @language
  end

  # GET /languages/1/edit
  def edit
    authorize @language
  end

  # POST /languages
  def create
    @language = Language.new(language_params)
    authorize @language
    flash[:notice] =  'The language was successfully saved!' if @language.save && !request.xhr?
    respond_with @language
  end

  # PATCH/PUT /languages/1
  def update
    @language.update(language_params)
    flash[:notice] =  'The language was successfully updated!' if @language.update(language_params) && !request.xhr?
    respond_with @language
  end

  # DELETE /languages/1
  def destroy
    authorize @language
    redirect_to languages_url, notice: 'Language was successfully destroyed.'  if @language.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_language
      @language = Language.find(params[:id])
    end

    def sort_column
      Language.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def language_params
      params.require(:language).permit(:lang, :lang_iso, :lang_iata)
    end
end
