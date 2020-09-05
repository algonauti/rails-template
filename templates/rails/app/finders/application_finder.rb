class ApplicationFinder
  include Pundit

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def search(params)
    accessible_records
  end

  def find(id)
    authorize(scope_finder.find(id), :show?)
  end

  protected

  def accessible_records
    if authorize(scope_model, :index?)
      scope_finder
    end
  end

  def scope_finder
    policy_scope(scope_model)
  end

  def scope_model
    self.class.name.chomp("Finder").constantize
  end

end
