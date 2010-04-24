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
      flash[:success] = t('custom_links.new.saved_successfully')
      redirect_to custom_links_path
    else
      render :action => :index
    end
  end

  def edit
  end

  def update
    if @custom_link.update_attributes(params[:custom_link])
      flash[:success] = t('custom_links.edit.updated_successfully')
      redirect_to custom_links_path
    else
      render :action => :edit
    end
  end

  def destroy
    @custom_link = CustomLink.find(params[:id])
    @custom_link.destroy
    flash[:success] = t('custom_links.delete.deleted_successfully')
    redirect_to custom_links_path
  end
  
  private

  def ensure_ownership_of_custom_link
    @custom_link = CustomLink.find(params[:id])
    if @custom_link.user != current_user
      flash[:error] = t('custom_links.index.you_cannot_edit_or_delete')
      redirect_to custom_links_path
    end
  end

end
