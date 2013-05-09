require "bundler/setup"
Bundler.require(:default, :development)

require "meta_validation"
require "#{File.dirname(__FILE__)}/support/schema.rb"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each do |file|
  require file
end
