include Sflx::Path
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

  index do
    selectable_column
    id_column
    column :title
    column :position
    column :parent_id
    column :depth
    column :slug
    column :link_url
    column :created_at
    actions
  end

  form html: { multipart: true } do |f|
    f.semantic_errors # shows errors on :base
    f.inputs "Gallery Details" do
      f.input :title
      f.input :body, :as => :ckeditor, input_html: { ckeditor: { height: 400 } }
      f.input :side_body, :as => :ckeditor
      f.input :menu_title
      f.input :show_in_menu
      f.input :slug
      f.input :link_url
      f.input :position
      f.input :depth # todo necessary to be filled
      f.input :parent_id # necessary if any
      f.input :view_template
      f.input :layout_template
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  #page.link_url => "test"
  #params[:link_url]="test"
  
  # before_save :test
  # def test
  #   self.link_url = "test"
  # end
  controller do
    before_action :set_page, only: [:show, :edit, :update, :destroy]

    def create
      @page = Page.new(permitted_params[:page]) 
      respond_to do |format|
        if @page.save
          @page.link_url = get_path @page
          @page.save
          format.html { redirect_to admin_pages_path, notice: 'Page was successfully created.' }
          format.json { render :show, status: :created, location: @page }
          format.js
        else
          format.html { render :new }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def update
      
      respond_to do |format|
        # byebug
        if @page.update(permitted_params[:page])
          
          @page.link_url = get_path @page
          
          @page.save
          format.html { redirect_to admin_page_path, notice: 'Page was successfully updated.' }
          format.json { render :show, status: :ok, location: @page }
        else
          format.html { render :edit }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    def set_page
      @page = Page.find(params[:id])
    end

    # def get_path
    #   if depth0?(@page)
    #     @page.slug
    #   elsif @page.parent_id == 3 && parent(@page).slug && @page.title
    #     parent(@page).slug + "?" + @page.title
    
    #   elsif parent(@page)
    #     parent(@page).slug + @page.slug
    #   end
    #   # if menu_item.slug.present?
    #   #   path = menu_item.slug
    #   # elsif menu_item.link_url.present?
    #   #   path = menu_item.link_url
    #   # end
    # end

    # def parent(menu_item)
    #   Page.find(menu_item.parent_id) if menu_item.parent_id.present?
    # end

    # def depth0?(menu_item)
    #   menu_item.depth == 0
    # end
  end
  
end
