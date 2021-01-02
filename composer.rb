require "bundler"
require "securerandom"
require "active_support/core_ext/string"

module Context
  def devise_secret_key
    SecureRandom.base64(64)
  end

  def master_key
    File.read('config/master.key') rescue nil
  end

  def pg_username
    "<%= ENV.fetch('PG_USER') { 'postgres' } %>"
  end

  def pg_password
    "<%= ENV.fetch('PG_PASSWORD') { 'postgres' } %>"
  end

  def pg_host
    "<%= ENV.fetch('PG_HOST') { 'localhost' } %>"
  end

  def pg_port
    "<%= ENV.fetch('PG_PORT') { '5432' } %>"
  end

  def module_name
    app_name.camelize
  end
end
extend Context

def compose!
  assert_minimum_rails_version
  add_template_repository_to_source_path
  remove_unused_files
  copy_templates
  copy_migrations

  initial_commit
end

def remove_unused_files
  run "rm app/assets/stylesheets/application.css"
end

def initial_commit
  run 'bundle install'
  run 'rake db:drop db:create db:migrate db:seed'
  run 'bundle exec annotate --models --force'
  git add: '.', commit: '-m "init rails with algonauti/rails-template"'
end

def copy_templates
  directory "rails", ".", force: true
end

def copy_migrations
  template "migrations/01_devise_create_users.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M")}01_devise_create_users.rb"
  template "migrations/02_create_doorkeeper_tables.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M")}02_create_doorkeeper_tables.rb"
end

def assert_minimum_rails_version
  requirement = Gem::Requirement.new("~> 6.1.0")
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails ~> 6.1.0. "\
           "You are using #{rails_version}. Continue anyway?"
  exit 1 if no?(prompt)
end


# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    # TODO
  else
    source_paths.unshift("#{File.dirname(__FILE__)}/templates")
  end
end

compose!
