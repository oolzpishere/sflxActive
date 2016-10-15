class PagesController < InheritedResources::Base
  before_action :find_by_path_or_id!, only: [:show]

  def show
    @page
    if params[:path] == "contact"
      render "contact" and return
    end
  end


  private


  def find_by_path_or_id
    path = params[:path]
    id = params[:id]
    if path
      @page = Page.where({slug: params[:path]}).first
    elsif id
      @page = Page.where({id: params[:id]}).first
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

