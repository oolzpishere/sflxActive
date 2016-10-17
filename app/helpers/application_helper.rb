module ApplicationHelper

  def menu_header
    menu_items = Page.all.order(:position)
        
    presenter = Pages::MenuPresenter.new( menu_items, self)
    presenter
  end

  def slideout_menu
    menu_items = Page.all.order(:position)
    
    presenter = Pages::SlideoutMenuPresenter.new( menu_items, self)
    presenter
  end


end
