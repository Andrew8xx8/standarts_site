# coding: utf-8
class BlockController < ApplicationController
  def index
    @blocks = Block.find_all_by_user_id(current_user.id)
  end

  def show
    @block = Block.find(params[:id])
    @points = Point.find_all_by_block_id(@block.id)
  end

  def edit
    @block = Block.find(params[:id])
  end

  def update
    updateBlock = Block.find(params[:id])
    if updateBlock.update_attributes(params[:block])
      flash[:success] = "Изменения вступили в силу"
      redirect_to :action => "show", :id => params[:id]
    else
      render standarts_path
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end
end
