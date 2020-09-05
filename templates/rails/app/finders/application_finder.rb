class ApplicationFinder
  include Pundit

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def search(params)
    raise NotImplementedError
  end

  def where(opts = :chain, *rest)
    if authorize(scope_model, :index?)
      scope_finder.where(opts, rest)
    end
  end

  def find(id)
    authorize(scope_finder.find(id), :show?)
  end

  protected

  def scope_finder
    policy_scope(scope_model)
  end

  def scope_model
    self.class.name.chomp("Finder").constantize
  end

end
