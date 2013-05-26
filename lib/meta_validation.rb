require "active_record"

module MetaValidation
  require "meta_validation/version"
  require "meta_validation/errors"
  require "meta_validation/base"
  require "meta_validation/predicate"
  require "meta_validation/scope"
end


ActiveRecord::Base.send(:include, MetaValidation)

