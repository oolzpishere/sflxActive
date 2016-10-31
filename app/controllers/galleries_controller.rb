class GalleriesController < InheritedResources::Base
  before_action :find_all_galleries
  before_action :find_all_gallery_types
  #  before_action :galleries_filter
  before_action :find_gallery, only: [:show]
  before_action :find_all_images, only: [:show]

  def index
    @galleries
    
  end

  def show
    @gallery
    @images
  end

  private

  def find_all_galleries
    query = params[:query].present? ? params[:query] : '*'
    @galleries = Elasticsearch::Model.search( query, [Gallery] ).records 

    
  end

  

  def find_all_gallery_types
    @gallery_types = GalleryType.order('position ASC')
  end

  def find_gallery
    @gallery = Gallery.find(params[:id])
  end

  def find_all_images
    @images = @gallery.images.order('position ASC')
  end

  def gallery_params
    params.require(:gallery).permit(:title, :body, :side_body, :position, :photos)
  end
end

