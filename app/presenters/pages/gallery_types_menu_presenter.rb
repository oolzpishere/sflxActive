# coding: utf-8
require 'active_support/core_ext/string'
require 'active_support/configurable'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/url_helper'

module Pages
  class GalleryTypesMenuPresenter
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
    include ActiveSupport::Configurable

    attr_accessor :context, :collection
    delegate :output_buffer, :output_buffer=, :to => :context

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
    self.list_tag_css = 'menu nav'
    self.link_tag_css = 'waves-effect waves-light'
    self.link_dropdown_tag_css = ' waves-effect waves-light'

    

    def initialize(collection, context)
      @collection = collection
      @context = context
    end

    def to_html
      render_menu_items(@collection.select {|item| item}) if @collection.present?
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
        
        buffer << render_menu_item_link(menu_item)
        buffer
      end
    end

    def render_menu_item_link(menu_item)
      link_to menu_item.name, context.url_for(controller: 'galleries', action: 'index', query: menu_item.name )
    end

    def menu_item_css(menu_item, index)
      css = []

      # css << active_css if descendant_item_selected?(menu_item)
      css << selected_css if selected_item?(menu_item)
      css << first_css if index == 0
      # css << last_css if index == menu_item.shown_siblings.length

      css.reject(&:blank?).presence
    end

    def selected_item?(item)
      typeName = URI.escape item.name
      @context.request.url =~ /#{typeName}/
    end
  end
end
