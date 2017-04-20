require 'digest/sha1'
class PagesController < InheritedResources::Base
  before_action :find_by_path_or_id!, only: [:show]


  def index
    signature = params[:signature]
    timestamp = params[:timestamp]
    nonce = params[:nonce]
    echostr = params[:echostr]
    if (check_signature signature, timestamp, nonce if params[:timestamp])
      respond_to do |format|
        format.html { render plain: echostr }
      end
    end
  end

  def show
    @page
   
    if params[:path] == "contact"
      render "contact" and return
    elsif  params[:path] == "contact/find_us"
      render "find_us" and return
    elsif params[:path] == "views"
      render "views" and return
    elsif params[:path] == "about"
      render "about" and return
    end
    
  end


  private

  def find_by_path_or_id
    if params[:path].present?
      @page ||= Page.where({link_url: "/#{params[:path]}"}).first
    elsif params[:id].present?
      @page ||= Page.where({id: params[:id]}).first
    end
  end

  def find_by_path_or_id!
    page = find_by_path_or_id

    raise ActiveRecord::RecordNotFound unless page

    page
  end

  def check_signature(signature, timestamp, nonce)
    
    token = "qhnDxVIxeS28h9mxSsJbyliZyFGUZHnb"
    tmpArr = Array.new.push(token, timestamp, nonce)
   
    tmpStr = tmpArr.sort.join
    tmpStr = Digest::SHA1.hexdigest tmpStr

    if ( tmpStr == signature )
      return true;
    else
      return false;
    end
  end

  def page_params
    params.require(:page).permit()
  end
end

