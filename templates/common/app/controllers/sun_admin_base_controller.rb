class SunAdminBaseController < ApplicationController
  before_filter :get_base_obj, only: [:edit, :update, :destroy, :show]
  before_filter :auth_admin, except: :show

  def index
    self.collections = klass.page(params[:page]).per(20)
  end

  def new
    self.single_obj = klass.new
  end

  def edit; end
  def show; end

  def create
    self.single_obj = klass.new(params[obj_str])
    to_or_not_to?(single_obj)
  end

  def update
    back_to_list single_obj.update_attributes(params[obj_str])
  end
 
  def destroy
    back_to_list(single_obj.destroy)
  end

  private

    def get_base_obj
      self.single_obj = klass.find(params[:id])
    end
end

