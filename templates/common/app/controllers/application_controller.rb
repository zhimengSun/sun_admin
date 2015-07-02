class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include AuthenticatedSystem, SharedHelper
  before_action :require_login_or_permission
  ActionController::Parameters.permit_all_parameters = true

  private
    def require_login_or_permission
      return redirect_to login_path unless session[:user_id]
      return true if current_user.can_access?(request.path) || current_user.is_admin?
      flash[:danger] = "您无此权限"
      redirect_to root_path
    end

    def back_to_list(condition = true, msg = nil)
      flash[condition ? :info : :danger] = 
        condition ? "操作成功" : single_obj.errors.full_messages.join("\n")
      flash[:info] = msg if msg
      redirect_to(action: :index)
    end

    def to_or_not_to?(obj)
      obj.save ? back_to_list("OK") : render(:new) 
    end

    def auth_admin
      return redirect_to root_path unless current_user.is_admin?
    end
end
