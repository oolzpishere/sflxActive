class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  # before_action :set_locale

  before_action :find_all_pages
  helper_method :generate_path

  def generate_path(page)
    if page.respond_to?(:slug) && page.slug.present?
      page.slug
    elsif page.respond_to?(:link_url) && page.link_url.present?
      page.link_url
    else
      controller = page.model_name.name.pluralize.downcase
      url_for controller: controller, action: 'show', id: page.id
    end
  end

  def access_denied(exception)
    redirect_to admin_dashboard_path, alert: exception.message
  end

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :admin, :user, :group])
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :admin, :user, :group)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :admin, :user, :group)
    end
  end

  private

  def set_admin_locale
    I18n.locale = 'zh-CN'
    # I18n.locale = current_admin_user && current_admin_user.locale || I18n.default_locale
  end

  def find_all_pages
    @mypages = Page.all
  end
end
