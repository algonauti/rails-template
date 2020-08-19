class BaseBinding
  def self.context(parent)
    new(parent).get_binding
  end

  def initialize(parent)
    @parent = parent
  end

  def get_binding
    binding
  end

  def app_name
    @parent.send :app_name
  end
end
