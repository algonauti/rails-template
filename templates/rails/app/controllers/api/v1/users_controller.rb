class Api::V1::UsersController < Api::BaseController
  def show
    render json: serialize(User.find(params[:id]))
  end

  private

  def serialize(user)
    UserSerializer.new(user).serializable_hash.to_json
  end
end
