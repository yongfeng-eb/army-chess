class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def require_login
    if params[:user_id].nil?
      flash[:error] = 'You must be logged in to access this page.'
      redirect_to '/'
    end
  end
end
