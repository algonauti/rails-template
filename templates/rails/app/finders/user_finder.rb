class UserFinder < ApplicationFinder
  def search(params)
    data = []
    if params[:email]
      data = where(email: params[:email])
    end
    data
  end
end
