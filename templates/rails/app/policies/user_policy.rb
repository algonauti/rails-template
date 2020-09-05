class UserPolicy < ApplicationPolicy
  def update?
    current_user.id == record.id
  end

  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
