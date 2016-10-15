class GalleriesController < InheritedResources::Base



  private



    def gallery_params
      params.require(:gallery).permit(:title, :body, :side_body, :position, :photos)
    end
end

