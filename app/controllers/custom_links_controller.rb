class CustomLinksController < ApplicationController
  before_filter :login_required
  before_filter :ensure_ownership_of_custom_link, :only => [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @custom_link.update_attributes(params[:custom_link])
      flash[:notice] = "Custom link updated successfully."
      redirect_to custom_links_path
    else
      render :action => :edit
    end
  end

  def destroy
    @custom_link = CustomLink.find(params[:id])
    @custom_link.destroy
    flash[:notice] = "Custom link successfully deleted."
    redirect_to custom_links_path
  end
  
  private

  def ensure_ownership_of_custom_link
    @custom_link = CustomLink.find(params[:id])
    if @custom_link.user != current_user
      flash[:error] = "You cannot edit or delete that custom link."
      redirect_to custom_links_path
    end
  end

end
