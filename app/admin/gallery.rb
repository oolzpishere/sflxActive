# -*- coding: utf-8 -*-
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

  index do
    selectable_column
    id_column
    column :title
    column "正文" do |gallery|
      gallery.body.truncate(100)
    end
    column :position
    column :created_at
    actions
  end

  form html: { multipart: true } do |f|
    f.semantic_errors # shows errors on :base
    f.inputs "Gallery Details" do
      f.input :title
      f.input :body, :as => :ckeditor, input_html: { ckeditor: { height: 400 } }
      f.input :side_body
      f.input :gallery_types, :as => :check_boxes
      f.input :cover, :as => :file, :hint => f.object.cover.present? ? image_tag(f.object.cover.url(:thumb)) : content_tag(:span, "no image yet")
      input :images, :as => :file, input_html: { multiple: true, name: "images[]"}
      
      #f.has_many :images, sortable: :position, allow_destroy: true, heading: 'images'  do |i|
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

  controller do
    before_action :set_gallery, only: [:show, :edit, :update, :destroy]
    def create
      @gallery = Gallery.new(permitted_params[:gallery])

      respond_to do |format|
        if @gallery.save
          if params[:images]
            params[:images].each { |image|
              @gallery.images.create(image: image)
            }
          end
          format.html { redirect_to admin_gallery_path, notice: 'Gallery was successfully created.' }
          format.json { render :show, status: :created, location: @gallery }
        else
          format.html { render :new }
          format.json { render json: @gallery.errors, status: :unprocessable_entity }
        end
      end

    end

    # @gallery = Gallery.new(gallery_params)


    def update
      #byebug
      respond_to do |format|
        if @gallery.update(permitted_params[:gallery])
          if params[:images]
            params[:images].each { |image|
              @gallery.images.create(image: image)
            }
          end
          format.html { redirect_to admin_gallery_path, notice: 'Gallery was successfully updated.' }
          format.json { render :show, status: :ok, location: @gallery }
        else
          format.html { render :edit }
          format.json { render json: @gallery.errors, status: :unprocessable_entity }
        end
      end
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end
    
  end


  
  permit_params do
    permitted = [:title, :body, :side_body, :position, :cover, :gallery_type_ids => [], images_attributes: [:id, :position, :gallery_id, :_destroy, :image, image: [] ]]
    permitted
  end



end
