class GalleriesController < InheritedResources::Base
  before_action :find_all_galleries

  def index
    @galleries
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  private

  def find_all_galleries
    @galleries = Gallery.order('position ASC')
  end

    def gallery_params
      params.require(:gallery).permit(:title, :body, :side_body, :position, :photos)
    end
end

