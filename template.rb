require "bundler"
require "securerandom"


Dir[File.join(__dir__, 'bindings', '*.rb')].each { |file| require file }

def apply_template!
  assert_minimum_rails_version
  add_template_repository_to_source_path
  copy_default_templates

  run 'bundle install'
end

def copy_default_templates
  template ".env.tt"
  template ".gitignore", force: true
  template "docker-compose.yml.tt"
  template "Dockerfile"
  template "Gemfile", force: true
  template "Procfile"
  template "README.md", force: true

  template "config/database.yml.tt",
    context: DatabaseConfigBinding.context(self),
    force: true

end

def assert_minimum_rails_version
  requirement = Gem::Requirement.new("~> 6.0.0")
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails ~> 6.0.0. "\
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

apply_template!
