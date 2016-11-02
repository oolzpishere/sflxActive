class PagesController < InheritedResources::Base
  before_action :find_by_path_or_id!, only: [:show]


  def index
  end

  def show
    @page
   
    if params[:path] == "contact"
      render "contact" and return
    elsif params[:path] == "views"
      render "views" and return
    end
    
  end


  private

  def find_by_path_or_id
    if params[:path].present?
      @page ||= Page.where({slug: "/#{params[:path]}"}).first
    elsif params[:id].present?
      @page ||= Page.where({id: params[:id]}).first
    end
    
  end

  def find_by_path_or_id!
    page = find_by_path_or_id

    raise ActiveRecord::RecordNotFound unless page

    page
  end

  def page_params
    params.require(:page).permit()
  end
end

