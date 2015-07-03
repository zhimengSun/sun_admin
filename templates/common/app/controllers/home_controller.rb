class HomeController < ApplicationController
  skip_before_action :require_login_or_permission
  def index

  end
end
