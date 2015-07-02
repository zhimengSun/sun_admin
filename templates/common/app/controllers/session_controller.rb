class SessionController < ApplicationController
  skip_before_action :require_login_or_permission
  def login
    current_user = auth_login(params[:login], params[:password])
    redirect_to root_path if current_user
    flash[:danger] = "登录失败"
  end
  
  def logout
    reset_session
    flash[:notice] = "已经登出"
    redirect_to root_path
  end 

  private
  def auth_login(login, password)
    User.find_by(name: login, password: password)
  end
end
