module MetaValidation 

  def self.included(klazz)
    @klazz = klazz
    self.create_predicate_methods
  end 

  private

    def self.klazz
      @klazz
    end   

    def self.inclusion_validators
      klazz.validators.delete_if do |v| 
        v.class.to_s != "ActiveModel::Validations::InclusionValidator"
      end 
    end

    def self.validators_in 
      inclusion_validators.sum { |v| v.options[:in] }
    end

    def self.duplicate_validators 
      validators_in.select { |e| validators_in.count(e) > 1 }.uniq
    end

    def self.create_predicate_methods
      verify!
      inclusion_validators.each do |v| 
        v.options[:in].each do |content|
          define_method "#{content}?" do
            send(v.attributes.first) == content
          end
        end
      end
    end

    def self.verify!
      verify_precedence!
      verify_duplicated!
    end

    def self.verify_precedence!
      return if validators_in.kind_of?(Array)
      if validators_in.zero?
        raise MetaValidationError, "Model #{klazz.to_s} has no validation of inclusion"
      end
    end

    def self.verify_duplicated!
      if duplicate_validators.any?
        raise MetaValidationError, "The following validators are in more than one field: #{duplicate_validators.to_sentence}"
      end
    end
end
