# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
include Pundit
require "active_support/all"
require "openweather2.rb"
require "sunriseset"
protect_from_forgery with: :exception, unless: -> { request.format.json? }
protect_from_forgery prepend: true
skip_before_action :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }
skip_before_action :verify_authenticity_token, if: :json_request?
#after_action :logging, only: [:create, :update, :destroy]
require "calendar_helper.rb"
require "tzinfo/data"
require 'i18n_timezones'
require 'devise_traceable'
#require 'suncalc'
before_action :store_current_location, :unless => :devise_controller?
before_action :authenticate_user!, :except => [:weather_grub, :error_404, :error_403, :error401]
helper_method :sort_column, :sort_direction
before_action :day_week
#layout :layout_by_resource
#def store_location
#  session[:return_to] = request.fullpath
#end
before_action :force_utf8_params
before_action  :set_p3p
before_action :set_locale
#rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
before_action :set_mobile_format
has_mobile_fu false
#before_action :force_mobile_format
before_action :set_timezone 
before_action :set_country
before_action :lang
#before_action :cache_on, only: [:index, :show, :new]
ActiveSupport::TimeZone::MAPPING["Ezhinsk"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Norok"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Arisha"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Alexandra"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Novonezhino"] = "Asia/Ezhinsk"
ActiveSupport::TimeZone::MAPPING["Magadan"] = "Asia/Magadan"
ActiveSupport::TimeZone::MAPPING["Sakhalin"] = "Asia/Sakhalin"
ActiveSupport::TimeZone::MAPPING["Kamchatka"] = "Asia/Kamchatka"
ActiveSupport::TimeZone::MAPPING["Anadyr"] = "Asia/Anadyr"
respond_to :html, :js, :json, :mobile
after_action :verify_authorized, :except => [:weather_grub, :error_404, :error_403, :error401]
after_action :store_action
rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

Openweather2.configure do |config|
  config.endpoint = 'https://api.openweathermap.org/data/2.5/weather'
#  config.apikey = '1cc9a2a59f851e39dfcfa8e29b62d584'
 config.apikey = '4b4fbe105fd022ead7bf99839bfadc2b'
end

def role?(role)
  return !!self.roles.find_by_name(role.to_s.camelize)
end

def set_timezone
    tz = current_user ? current_user.time_zone : nil
    Time.zone = tz || ActiveSupport::TimeZone["Ezhinsk"]
end  

def set_country
  @countr = current_user ? current_user.country : nil
  @country = @countr || Country.find(508)
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

#  def create
#    @flash_message_state_id = 401
#  end

#  def update
#    @flash_message_state_id = 402
#  end

#  def destroy
#    @flash_message_state_id = 405
#  end

  def set_locale
    if user_signed_in?
      I18n.locale = current_user.language.lang_iata.to_s.downcase
    else
      I18n.default_locale
    end
  end

#  def default_url_options(options = {})
#    { locale: I18n.locale }.merge options
#  end

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
   @flash = flash[:notice]
   @flash_message_state_id = 100
   flash_message_add
#    request.referrer || user_path(current_user) and return
#    session[:previous_url] || current_user
    current_user
  end

  def after_update_path_for(resource)
    session[:previous_url] || current_user
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def set_p3p
    response.headers["P3P"]='CP="CAO PSA OUR"'
  end 

  private 
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def record_not_found
    render "errors/error_404", status: 404
  end

  def set_mobile_format
    if is_mobile_device?
      unless request.format.js? || request.format.json?
        request.format = :mobile
      end
#      render layout: "layouts/application.mobile"
#      is_device?("iphone") ? request.format = :html : super
#      if (devise_controller? && action_name == 'create' && request.method == ('POST'))
#        request.format = :html
#      else
#        request.format = :mobile
#      end
    end
  end

  def logging
    @flash = flash[:notice]
    flash_message_add
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  protected

  def store_action
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
#      store_location_for(:user, request.fullpath)
      session[:previous_url] = request.fullpath
    end
  end

  def user_not_authorized
    flash[:notice] = "Данное действие тебе не разрешено."
    @flash = flash[:notice]
    @flash_message_state_id = 403
    flash_message_add
    redirect_to (request.referrer || error403_path), data: { no_turbolink: true } and return
  end

  def lang
    @langs = Language.all
  end

  def flash_message_add
    @flash_message = FlashMessage.new
    current_user.nil? ? @flash_message.user_id = 0 : @flash_message.user_id =  current_user.id
    @flash_message.request_url = request.original_url
    @flash_message.request_ip = request.ip
    @flash_message.request_method = request.request_method
    request.referrer.nil? ? @flash_message.request_referrer = request.original_url : @flash_message.request_referrer = request.referrer
    @flash_message.useragent = request.env['HTTP_USER_AGENT']
    @flash_message.message = @flash || "empty"
    @flash_message.flash_message_state_id = @flash_message_state_id
    @flash_message.save
  end

  def layout_by_resource
    if devise_controller?
      "application_empty_1"
    else
      "application"
    end
  end

  def json_request?
    request.format.json?
  end

  def day_week
    @wday = Time.zone.now.strftime'%w'.to_s
  end

  def cache_on
    expires_in 15.minutes, :public => false
    sleep 15
  end
end
