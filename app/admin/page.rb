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


end
