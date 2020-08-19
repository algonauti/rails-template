class DatabaseConfigBinding < BaseBinding
  def username
    "<%= ENV.fetch('POSTGRES_USER') { 'postgres' } %>"
  end

  def password
    "<%= ENV.fetch('POSTGRES_PASSWORD') { 'postgres' } %>"
  end

  def host
    "<%= ENV.fetch('POSTGRES_HOST') { 'localhost' } %>"
  end

  def port
    "<%= ENV.fetch('POSTGRES_PORT') { '5432' } %>"
  end
end
