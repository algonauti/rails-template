class ApplicationFinder
  include Pundit

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def find(id)
    authorize(policy_scope(policy_scope_model).find(id), :show?)
  end

  protected

  def policy_scope_model
    self.class.name.chomp("Finder").constantize
  end

end
