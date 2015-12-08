class Users::SessionsController < Devise::SessionsController
  after_action :verify_authorized, :except => [:new, :create, :destroy]
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
#  def new
#    if user_signed_in?
#      redirect_to current_user
#    else
#      super
#      render "devise/sessions/new"
#    end
#  end

  # POST /resource/sign_in
  def create
    if HackerTracker.hacker?(request.remote_ip)
      set_flash_message :alert, :ip_blocked
      redirect_to new_user_session_path
    else
      super
    end
  end

  # DELETE /resource/sign_out
  def destroy
     super
  end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

end
