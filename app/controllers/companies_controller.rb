#coding: utf-8
class CompaniesController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :have_access, :only => [:index]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    @all = Company.scoped
  end

  def new
    @user = User.find(params[:user_id])
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    @user = User.find(params[:user_id])
    if @company.save
      @user.update_attribute(:company_id, @company.id)
      sign_in @user
      redirect_to standard_index_path, flash: { success: "Успешно добавлена информация о компании. Регистрация прошла успешно!" }
    else
      render "new"
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    @user = User.find_by_company_id(@company)
    if @company.update_attributes(params[:company])
      redirect_to edit_company_path(@company), flash: { success: "Обновление прошло успешно" }
    else
      render "edit"
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def destroy
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def have_access
    redirect_to root_path unless current_user_super_admin?
  end

  def correct_user
    @user = Company.find(params[:id]).user
    redirect_to root_path unless current_user?(@user)
  end
end