class SessionController < ApplicationController
  skip_before_action :require_login_or_permission
  def login
  end
  
  def logout
  end 
end
