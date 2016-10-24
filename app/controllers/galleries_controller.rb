class GalleriesController < InheritedResources::Base
  before_action :find_all_galleries
  before_action :find_all_gallery_types
  before_action :galleries_filter

  def index
    @galleries_filter
    
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  private

  def find_all_galleries
    @galleries = Gallery.order('position ASC')
  end

  def galleries_filter
    @galleries_filter ||= Array.new
    if params[:gallery_type].present?
      @galleries.each do |g|
        g.gallery_types.each do |type|
          if type.name == params[:gallery_type]
            @galleries_filter << g
          end
        end
      end
    else
      @galleries_filter = @galleries
    end
  end

  def find_all_gallery_types
    @gallery_types = GalleryType.order('position ASC')
  end

  def gallery_params
    params.require(:gallery).permit(:title, :body, :side_body, :position, :photos)
  end
end

