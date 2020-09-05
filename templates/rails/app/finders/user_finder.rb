class UserFinder < ApplicationFinder

  def search(params)
    filters = build_filters(params)

    data = accessible_records
    if filters[:email]
      data = data.where(email: filters[:email])
    end
    data
  end

  def build_filters(params)
    params.require(:filters).permit(
      :email
    )
  end
end
