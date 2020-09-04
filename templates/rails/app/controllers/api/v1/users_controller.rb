class Api::V1::UsersController < Api::BaseController
  def show
    respond_with UserFinder.new(current_user).find(params[:id])
  end
end
