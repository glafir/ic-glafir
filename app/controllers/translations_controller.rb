class TranslationsController < ApplicationController
  before_action :set_translation, only: [:show, :edit, :update, :destroy]

  # GET /translations
  def index
    @translations = Translation.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @translations
    respond_with @translations
  end

  # GET /translations/1
  def show
    authorize @translation
    respond_with @translation
  end

  # GET /translations/new
  def new
    @translation = Translation.new
    authorize @translation
    respond_with @translation
  end

  # GET /translations/1/edit
  def edit
    authorize @translation
  end

  # POST /translations
  def create
    @translation = Translation.new(translation_params)
    authorize @translation
    flash[:notice] =  'The translation was successfully saved!' if @translation.save && !request.xhr?
    respond_with @translation
  end

  # PATCH/PUT /translations/1
  def update
    @translation.update(translation_params)
    flash[:notice] =  'The translation was successfully updated!' if @translation.update(translation_params) && !request.xhr?
    respond_with @translation
  end

  # DELETE /translations/1
  def destroy
    authorize @translation
    redirect_to translations_url, notice: 'Translation was successfully destroyed.'  if @translation.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_translation
      @translation = Translation.find(params[:id])
    end

    def sort_column
      Translation.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def translation_params
      params.require(:translation).permit(:locale, :key, :value, :interpolations, :is_proc)
    end
end
