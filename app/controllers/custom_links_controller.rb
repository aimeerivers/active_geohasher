class CustomLinksController < ApplicationController
  before_filter :login_required

  def index
    @new_custom_link = CustomLink.new(:url => 'http://')
  end
  
  def create
    @new_custom_link = CustomLink.new(params[:custom_link])
    @new_custom_link.user = current_user
    if @new_custom_link.save
      flash[:notice] = "Custom link saved successfully."
      redirect_to custom_links_path
    else
      render :action => :index
    end
  end

  def destroy
    @custom_link = CustomLink.find(params[:id])
    if @custom_link.user == current_user
      @custom_link.destroy
      flash[:notice] = "Custom link successfully deleted."
    else
      flash[:error] = "You cannot delete that custom link."
    end
    redirect_to custom_links_path
  end

end
