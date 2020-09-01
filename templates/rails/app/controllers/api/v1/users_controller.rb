class Api::V1::UsersController < Api::BaseController
  def show
    render json: User.find(params[:id])
  end
end
