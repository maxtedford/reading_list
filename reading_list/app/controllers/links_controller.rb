class LinksController < ApplicationController
  before_action :current_user
  
  def index
    @links = current_user.links
  end
  
  def create
    link = current_user.links.new(link_params)
    if link.save
      flash[:message] = "You've added #{link.url} to your list"
      redirect_to links_path
    else
      flash.now[:errors] = link.errors.full_messages.join(", ")
      redirect_to links_path
    end
  end
  
  def update
    link = Link.find(params[:id].to_i)
    update_read_status(link)
    flash[:message] = "Updated #{link.url}"
    redirect_to links_path
  end
  
  private
  
  def update_read_status(link)
    if link.read
      link.update_attributes(read: false)
    else
      link.update_attributes(read: true)
    end
  end
  
  def link_params
    params.require(:link).permit(:url, :read, :user_id)
  end
end
