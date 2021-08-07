class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :flag

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def flag
    @flag = false
  end

  def remain_search_keyword
    @keyword = params[:keyword]
  end
end
