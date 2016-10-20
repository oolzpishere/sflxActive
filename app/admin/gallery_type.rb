ActiveAdmin.register GalleryType do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  menu parent: "Galleries"

  permit_params :name, :position



end
