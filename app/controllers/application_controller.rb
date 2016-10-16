class ApplicationController < ActionController::Base
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

  private

  def find_all_pages
    @mypages = Page.all
  end
end
