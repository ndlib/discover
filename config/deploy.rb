# Add the deploy directory to the load path
$:.unshift File.join(File.dirname(__FILE__),'deploy')
require 'hesburgh/common'
require 'hesburgh/git'
require 'hesburgh/vm'
require 'hesburgh/rails'
require 'hesburgh/rails_db'
require 'hesburgh/jenkins'
require 'hesburgh/prompt_branch'
# require 'hesburgh/whenever'
begin
  require 'hipchat/capistrano'
  require 'new_relic/recipes'
  require 'airbrake/capistrano'

  after "deploy:update", "newrelic:notice_deployment"
rescue LoadError
end

set :application, 'discover'
set :repository,  "https://github.com/ndlib/discover.git"
set :ruby_bin, "/opt/rh/rh-ruby22/root/usr/bin"

# set :application_symlinks, ['config/initializers/devise_secret.rb']

set :hipchat_token, "c290a842542721d6aee18a3cb900a1"
set :hipchat_room_name, "Web and Software Engineering"
set :hipchat_announce, false # notify users?

desc "Setup for the Pre-Production environment"
task :pre_production do
  # Customize pre_production configuration
  set :rails_env, 'pre_production'
  role :app, "discoverpprd.library.nd.edu"
end

desc "Setup for the production environment"
task :production do
  # Customize production configuration
  set :rails_env, 'production'
  role :app, "discoverprod-vm.library.nd.edu"
end
