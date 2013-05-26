module MetaValidation 

  def self.included(base)
    base.extend(ClassMethods)
  end 

  module ClassMethods

    def acts_as_meta_validation(options = {})
      configuration.update(options)
      begin
        verify!
        create_predicate_methods
        create_scope_methods
      rescue => e
        if e.kind_of?(MetaValidation::MetaValidationError)
          raise e
        else
          raise MetaValidation::MetaValidationError, "Maybe you found a bug, you got a not expected exception. Report this on https://github.com/maurogeorge/meta_validation/issues"
        end
      end
    end

    private

      def klazz
        self
      end   

      def configuration
        @configuration ||= { scoped: false }
      end

      def inclusion_validators
        klazz.validators.delete_if do |v| 
          v.class.to_s != "ActiveModel::Validations::InclusionValidator"
        end 
      end

      def validators_in 
        inclusion_validators.sum { |v| v.options[:in] }
      end

      def duplicate_validators 
        validators_in.select { |e| validators_in.count(e) > 1 }.uniq
      end

      def verify!
        verify_precedence!
        verify_duplicated!
      end

      def verify_precedence!
        return if validators_in.kind_of?(Array)
        if validators_in.zero?
          raise MetaValidationError, "Model #{klazz.to_s} has no validation of inclusion"
        end
      end

      def verify_duplicated!
        if duplicate_validators.any?
          raise MetaValidationError, "The following validators are in more than one field: #{duplicate_validators.to_sentence}"
        end
      end
  end
end
