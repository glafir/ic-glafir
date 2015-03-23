# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
before_filter :authenticate_user!
helper_method :sort_column, :sort_direction

#require 'date'
#layout :layout_by_resource
#def store_location
#  session[:return_to] = request.fullpath
#end
before_filter :force_utf8_params
#before_action :set_locale
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
has_mobile_fu
before_filter :set_mobile_format
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def force_utf8_params
  traverse = lambda do |object, block|
        if object.kind_of?(Hash)
          object.each_value { |o| traverse.call(o, block) }
        elsif object.kind_of?(Array)
          object.each { |o| traverse.call(o, block) }
        else
          block.call(object)
        end
      object
    end
    force_encoding = lambda do |o|
      o.force_encoding(Encoding::UTF_8) if o.respond_to?(:force_encoding)
    end
  traverse.call(params, force_encoding)
  end

def after_sign_in_path_for(resource)
  airports_path
end

def after_sign_out_path_for(resource_or_scope)
  root_to_path
end

  private 
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def record_not_found
    render plain: "404 Not Found", status: 404
  end

def set_request_format
  if is_mobile_device? # this method is provided by mobile_fu
    if (devise_controller? && action_name == 'create' && request.method == ('POST'))
      request.format = :html
    else
      request.format = :mobile
    end
  end
end


#  protected
#  def layout_by_resource
#    if devise_controller?
#      "application_empty_1"
#    else
#      "application"
#    end
#  end
protect_from_forgery
end
