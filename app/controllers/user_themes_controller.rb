class UserThemesController < ApplicationController
  before_action :set_user_theme, only: [:show, :edit, :update, :destroy]

  def index
    @user_themes = UserTheme.order(:theme)
    authorize @user_themes
    respond_with(@user_themes)
  end

  def show
    authorize @user_theme
    respond_with(@user_theme)
  end

  def new
    @user_theme = UserTheme.new
    authorize @user_theme
    respond_with(@user_theme)
  end

  def edit
    authorize @user_theme
  end

  def create
    authorize :user_theme
    @user_theme = UserTheme.new(user_theme_params)
    @user_theme.save
    respond_with(@user_theme)
  end

  def update
    authorize :user_theme
    @user_theme.update_attributes(user_theme_params)
    respond_with(@user_theme)
  end

  def destroy
    authorize :user_theme
    @user_theme.destroy
    respond_with(@user_theme)
  end

  private
    def set_user_theme
      @user_theme = UserTheme.find(params[:id])
    end

  def user_theme_params
    params.require(:user_theme).permit(:theme)
  end
end
