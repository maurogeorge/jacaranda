require "active_record"

module MetaValidation
  require "meta_validation/version"
  require "meta_validation/errors"
  require "meta_validation/predicate"
end


ActiveRecord::Base.send(:include, MetaValidation)

