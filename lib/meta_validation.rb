require "active_record"

module MetaValidation
  require "meta_validation/version"
  require "meta_validation/errors"
  require "meta_validation/predicate"
end

class ActiveRecord::Base
  def self.acts_as_meta_validation
    begin
      include MetaValidation
    rescue => e
      if e.kind_of?(MetaValidation::MetaValidationError)
        raise e
      else
        raise MetaValidation::MetaValidationError, "Maybe you found a bug, you got a not expected exception. Report this on https://github.com/maurogeorge/meta_validation/issues"
      end
    end
  end
end

