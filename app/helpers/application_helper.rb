module ApplicationHelper


  def render_menu_item_link(menu_item)
    link_tag_css = ""
    path = get_path menu_item
    if path =~ /galleries/
      mcontroller = path.slice(/^\/?\w+/) # get 'galleries'
      url_for controller: mcontroller, action: 'index', query: menu_item.title
    elsif path =~ /^\/$/
      url_for controller: 'pages', action: 'index'
    elsif menu_item.model_name.plural =~ /galleries/ 
      url_for controller: menu_item.model_name.plural, action: 'show', id: menu_item.id
    else
      url_for path 
    end
  end

  def get_path(menu_item)
    if menu_item.respond_to?(:slug) && menu_item.slug.present?
      path = menu_item.slug
    elsif menu_item.respond_to?(:link_url) && menu_item.link_url.present?
      path = menu_item.link_url
    end
  end

  private
  
  def menu_items
    Page.all.order(:position)
  end


end
