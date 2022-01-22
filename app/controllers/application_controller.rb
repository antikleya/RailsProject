# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :set_locale
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password])
  end

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale.to_sym : nil
  end

  def require_admin
    redirect_to room_path(params[:locale], @room), notice: 'You must be an admin for this action' unless admin?(@room)
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def set_table
    @table = @room.table
  end
end
