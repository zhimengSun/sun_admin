class SunAdminBaseController < ApplicationController
  before_filter :get_user, only: [:edit, :update, :destroy]
  before_filter :auth_admin, except: :show
  
  def index
    single_objs = klass.page(params[:page]).per(20)
  end

  def new
    single_obj = klass.new
  end

  def edit
  end

  def create
    single_obj = klass.new(params[:user])
    to_or_not_to?(single_obj)
  end

  def update
    back_to_list single_obj.update_attributes(params[obj_str])
  end
  
  def destroy
    back_to_list(single_obj.destroy)
  end

  private

    def get_user
      single_obj = klass.find(params[:id])
    end
end
