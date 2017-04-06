module Sflx
  module Path
    # when create a new page,if depth is nil. get_path will not execute.
    def get_path(menu_item)
      if depth0?(menu_item)
        menu_item.slug
      elsif menu_item.parent_id == 3 && mparent(menu_item).slug && menu_item.title
        mparent(menu_item).slug + "?" + menu_item.title
        
      elsif mparent(menu_item)
        mparent(menu_item).slug + menu_item.slug
      end
      # if menu_item.slug.present?
      #   path = menu_item.slug
      # elsif menu_item.link_url.present?
      #   path = menu_item.link_url
      # end
    end

    private
    def mparent(menu_item)
      Page.find(menu_item.parent_id) if menu_item.parent_id.present?
    end

    def depth0?(menu_item)
      menu_item.depth == 0
    end


  end
end
