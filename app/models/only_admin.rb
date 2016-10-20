class OnlyAdmin < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    case subject
    when normalized(Page)
      user.admin?
    else
      true
    end
  end

end
