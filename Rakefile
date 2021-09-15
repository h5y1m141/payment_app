# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

# https://github.com/yukihirop/r2-oas#-requirements
R2OAS.load_tasks if Rails.env.development?