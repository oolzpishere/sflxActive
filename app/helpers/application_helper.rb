module ApplicationHelper

  def menu_header
    menu_items = Page.all.order(:position)
        
    presenter = Pages::MenuPresenter.new( menu_items, self)
    presenter
  end

end
