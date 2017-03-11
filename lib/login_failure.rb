class LoginFailure < Devise::FailureApp
  def redirect_url
    error401_path
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
