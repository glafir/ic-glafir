# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
protect_from_forgery

require 'sunriseset'
require 'tzinfo'
require 'tzinfo/data'
require 'i18n_timezones'

#require 'suncalc'
before_filter :authenticate_user!
helper_method :sort_column, :sort_direction
respond_to :html, :mobile, :json, :js
#require 'date'
#layout :layout_by_resource
#def store_location
#  session[:return_to] = request.fullpath
#end
before_filter :force_utf8_params
#before_action :set_locale
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
has_mobile_fu(true)
before_filter :set_mobile_format
before_filter :set_timezone 
ActiveSupport::TimeZone::MAPPING["Ezhinsk"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Norok"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Arisha"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Alexandra"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Novonezhino"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Magadan"] = "Asia/Magadan"
ActiveSupport::TimeZone::MAPPING["Sakhalin"] = "Asia/Sakhalin"
ActiveSupport::TimeZone::MAPPING["Kamchatka"] = "Asia/Kamchatka"
ActiveSupport::TimeZone::MAPPING["Anadyr"] = "Asia/Anadyr"

def set_timezone
#    Time.zone = ActiveSupport::TimeZone.new("Ezhinsk")
    tz = current_user ? current_user.time_zone : nil
    Time.zone = tz || ActiveSupport::TimeZone["Ezhinsk"]
end  
 
def validator(object)
  object.valid?
  model = object.class.name.underscore.to_sym
  field = params[model].first[0]
  @errors = object.errors[field]

  if @errors.empty?
    @errors = true
  else
    name = t("activerecord.attributes.#{model}.#{field}")
    @errors.map! { |e| "#{name} #{e}<br />" }
  end
end

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

#def after_sign_out_path_for(resource_or_scope)
#  root_path
#end

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
end
