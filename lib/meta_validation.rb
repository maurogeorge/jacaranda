require "active_record"

module MetaValidation
  require "meta_validation/version"
  require "meta_validation/errors"
  require "meta_validation/predicate"
end

class ActiveRecord::Base
  def self.acts_as_meta_validation
    include MetaValidation
  end
end

