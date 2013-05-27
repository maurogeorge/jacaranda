require "active_record"

I18n.load_path << File.join(File.dirname(__FILE__), "config", "locales", "en.yml")

module MetaValidation
  require "meta_validation/version"
  require "meta_validation/errors"
  require "meta_validation/base"
  require "meta_validation/predicate"
  require "meta_validation/scope"
end


ActiveRecord::Base.send(:include, MetaValidation)

