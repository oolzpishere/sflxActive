ActiveAdmin.register Gallery do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form html: { multipart: true } do |f|
  f.semantic_errors # shows errors on :base
    f.inputs "Gallery Details" do
      f.input :title
      f.input :body, :as => :ckeditor, input_html: { ckeditor: { height: 400 } }
      f.input :side_body
      
      f.has_many :images, sortable: :position, allow_destroy: true, heading: 'images'  do |i|
        i.input :image, :as => :file, :hint => i.object.image.present? ? image_tag(i.object.image.url(:thumb)) : content_tag(:span, "no image yet")
      end
      #,input_html: { multiple: true}
      
      

      # f.input :image_cache, :as => :hidden 

      f.input :position
    end

    # f.inputs "Image", :for => [:image, f.object.images || Image.new ] do |fi|
    #   fi.input :image, :for => :image, :as => :file
    # end




  f.actions         # adds the 'Submit' and 'Cancel' buttons
end

permit_params do
  permitted = [:title, :body, :side_body, :position, images_attributes: [:id, :position, :gallery_id, :_destroy, :image , image: [] ]]
  permitted
end

end
