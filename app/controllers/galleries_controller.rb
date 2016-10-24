class GalleriesController < InheritedResources::Base
  before_action :find_all_galleries
  before_action :find_all_gallery_types
#  before_action :galleries_filter

  def index
    @galleries
    
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  private

  def find_all_galleries
    query = params[:query].present? ? params[:query] : '*'
    @galleries = Elasticsearch::Model.search( query, [Gallery] ).records 

    
  end



  def find_all_gallery_types
    @gallery_types = GalleryType.order('position ASC')
  end

  def gallery_params
    params.require(:gallery).permit(:title, :body, :side_body, :position, :photos)
  end
end

