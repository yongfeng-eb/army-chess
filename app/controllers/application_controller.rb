class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def require_login
    user_id = params[:user_id]
    if user_id.nil?
      flash[:error] = 'You must be logged in to access this page.'
      redirect_to '/'
    else
      player_user_id = Player.all.pluck(:user_id)
      unless player_user_id.include?(user_id)
        flash[:error] = 'User id does not exist.'
        redirect_to '/'
      end
    end
  end
end
