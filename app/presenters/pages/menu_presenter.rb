# coding: utf-8
require 'active_support/core_ext/string'
require 'active_support/configurable'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/url_helper'

module Pages
  class MenuPresenter
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
    include ActiveSupport::Configurable

# %ul.right.hide-on-med-and-down
#   - @pages.each do |page|
#     - if page.slug
#       - path = page.slug
#     - elsif page.link_url
#       -path = page.link_url

#     %li= link_to page.title, path, class: "waves-effect waves-light"

    config_accessor :roots, :menu_tag, :list_tag, :list_item_tag, :css, :dom_id,
    :max_depth, :active_css, :selected_css, :first_css, :last_css, :list_tag_css, 
    :link_tag_css, :link_dropdown_tag_css, :list_item_opt_tag, :list_item_opt, :list_tag_id

    self.dom_id = ''
    self.css = ''
    self.menu_tag = :nav
    self.list_tag = :ul
    self.list_item_tag = :li
    self.active_css = :active
    self.selected_css = :selected
    self.first_css = :first
    self.last_css = :last
    self.list_tag_css = 'right hide-on-med-and-down'
    self.link_tag_css = 'waves-effect waves-light'
    self.link_dropdown_tag_css = 'dropdown-button waves-effect waves-light'
 

    attr_accessor :context, :collection
    delegate :output_buffer, :output_buffer=, :to => :context

    def initialize(collection, context)
      @collection = collection
      @context = context
    end

    def to_html
      render_menu_items(@collection.select {|item| item.parent_id.blank?}) if @collection.present?
    end

    private

    def render_menu_items(menu_items)
      if menu_items.present? 
        content_tag(list_tag, :id => list_tag_id, :class => list_tag_css) do
          menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
            buffer << render_menu_item(item, index)
          end
        end
      end
    end

    def render_menu_item(menu_item, index)
      content_tag(list_item_tag, :class => menu_item_css(menu_item, index), list_item_opt_tag => list_item_opt) do
        buffer = ActiveSupport::SafeBuffer.new
        
        if check_for_dropdown_item(menu_item)
          buffer << render_menu_item_link_dropdown(menu_item)
        else
          buffer << render_menu_item_link(menu_item)
        end 

        buffer << render_menu_items_children(menu_item_children(menu_item))

        buffer
      end
    end

    def check_for_dropdown_item(menu_item)
      path = get_path menu_item 
      path == "/galleries" or path =="/contact"
    end

    def render_menu_item_link(menu_item)
      if menu_item.link_url == "/"
        link_to(menu_item.title, context.url_for(controller: 'pages', action: 'index',only_path: true), :class => link_tag_css)
      else
        if menu_item.slug.present?
          path = menu_item.slug
        elsif menu_item.link_url.present?
          path = menu_item.link_url
        end
        if menu_item_of_gallery_type? menu_item
          link_to(menu_item.title, context.url_for(controller: 'galleries', action: 'index', gallery_type: menu_item.title ), :class => link_tag_css)
        else
          link_to(menu_item.title, context.url_for(path), :class => link_tag_css)
        end
      end
    end

    def menu_item_of_gallery_type?(menu_item)
      menu_item.parent_id == 3 if menu_item.parent_id.present?
    end

    def render_menu_item_link_dropdown(menu_item)
      dropdownid = "dropdown#{menu_item.id}"
      path = get_path menu_item
      
      link_to( context.url_for( path ), :class => link_dropdown_tag_css, data: {activates: dropdownid} ) do
        str = "#{menu_item.title}<i class=\"fa fa-chevron-down right\" aria-hidden=\"true\"></i>"
        str.html_safe
      end
    end

    def menu_item_css(menu_item, index)
      css = []

      # css << active_css if descendant_item_selected?(menu_item)
      # css << selected_css if selected_item?(menu_item)
      css << first_css if index == 0
      # css << last_css if index == menu_item.shown_siblings.length

      css.reject(&:blank?).presence
    end

    def menu_item_children(menu_item)
      path = get_path menu_item 
      if path == "/galleries" or path =="/contact"
        @collection.select { |item| item.parent_id == menu_item.id }
      end
    end

    def get_path(menu_item)
      if menu_item.slug.present?
        path = menu_item.slug
      elsif menu_item.link_url.present?
        path = menu_item.link_url
      end
    end

    def render_menu_items_children(menu_items)
      if menu_items.present?
        dropdownid = "dropdown#{menu_items.first.parent_id}"
        content_tag(list_tag, :id => dropdownid, :class => 'dropdown-content') do
          menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
            buffer << render_menu_item(item, index)
          end
        end
      end
    end


  end
end
