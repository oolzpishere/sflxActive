ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :admin, :manager, :user, :group

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin, :as => :boolean
      f.input :manager, :as => :boolean
      f.input :user, :as => :boolean
      f.input :group, :as => :boolean
    end
    f.actions
  end

end
