module Jacaranda 

  def self.included(base)
    base.extend(ClassMethods)
  end 

  module ClassMethods

    def acts_as_jacaranda(options = {})
      configuration.update(options)
      begin
        verify!
        create_predicate_methods
        create_scope_methods
      rescue => e
        if e.kind_of?(Jacaranda::JacarandaError)
          raise e
        else
          raise Jacaranda::JacarandaError, I18n.translate("jacaranda.errors.messages.unknown")
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
          raise JacarandaError, I18n.translate("jacaranda.errors.messages.precedence", model: klazz.to_s)
        end
      end

      def verify_duplicated!
        if duplicate_validators.any?
          raise JacarandaError, I18n.translate("jacaranda.errors.messages.duplicated", model: klazz.to_s, validators: duplicate_validators.to_sentence)
        end
      end
  end
end
