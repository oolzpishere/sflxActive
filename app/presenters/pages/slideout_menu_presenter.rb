require 'active_support/core_ext/string'
require 'active_support/configurable'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/url_helper'
require 'sflx/path'
module Pages
  class SlideoutMenuPresenter < MenuPresenter
    #include Sflx::Path
    self.menu_tag = :div
    self.list_tag = :ul
    self.list_item_tag = :li
    self.active_css = :active
    self.selected_css = :selected
    self.first_css = :first
    self.last_css = :last
    self.last_css = nil
    self.list_tag_css = 'side-nav collapsible collapsible-accordion'
    self.list_tag_id = 'slide-out'
    self.link_tag_css = 'waves-effect waves-teal'

    def render_menu_item_link_dropdown(menu_item)
      str = "<a class= \"collapsible-header waves-effect waves-teal\">
                #{menu_item.title}
                <i class=\"fa fa-chevron-down \" aria-hidden=\"true\"></i>
            </a>"
      str.html_safe
    end

    def render_menu_items_children(menu_items)
      if menu_items.present?
        content_tag(list_tag, :id =>"", :class => 'collapsible-body') do
          menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
            buffer << render_menu_item(item, index)
          end
        end
      end
    end



  end
end
