class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :find_all_pages
  helper_method :generate_path

  def generate_path(page)
    #byebug
    if page.slug.present?
      page.slug
    elsif page.link_url.present?
      page.link_url
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
    devise_parameter_sanitizer.permit(:sign_up, :account_update) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :admin, :user, :group)
    end
  end

  private

  def find_all_pages
    @mypages = Page.all
  end
end
