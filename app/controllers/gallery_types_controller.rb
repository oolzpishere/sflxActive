class GalleryTypesController < InheritedResources::Base

  def index
    # @galleries
  end

  def show
    #@gallery = Gallery.find(params[:id])
  end

  private

  def gallery_types_params
    params.require(:gallery_types).permit(:name, :position)
  end

end
