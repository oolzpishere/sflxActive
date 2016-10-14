ActiveAdmin.register Page do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or

permit_params do
  permitted = [ :parent_id, :path, :slug, :custom_slug, :show_in_menu, :link_url, :menu_match, :deletable, :draft, :skip_to_first_child, :lft, :rgt, :position, :depth, :view_template, :layout_template, :title, :menu_title, :body, :side_body, :show_in_footer, :locale ]
  # permitted << :other if params[:action] == 'create' && current_user.admin?
  permitted
end

form html: { multipart: true } do |f|
  f.semantic_errors # shows errors on :base
    f.inputs "Gallery Details" do
      f.input :title
      f.input :body, :as => :ckeditor, input_html: { ckeditor: { height: 400 } }
      f.input :side_body, :as => :ckeditor
      f.input :menu_title
      f.input :show_in_menu
      f.input :view_template
      f.input :layout_template

      f.input :position
    end





  f.actions         # adds the 'Submit' and 'Cancel' buttons
end

end
