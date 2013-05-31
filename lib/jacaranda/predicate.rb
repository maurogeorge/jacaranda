module Jacaranda 
  module ClassMethods

    private

      def create_predicate_methods
        inclusion_validators.each do |v| 
          v.options[:in].each do |content|
            define_method build_predicate_name(v.attributes.first, content) do
              send(v.attributes.first) == content
            end
          end
        end
      end

      def build_predicate_name(column, name)
        if configuration[:scoped]
          "#{column}_#{name}?"
        else
          "#{name}?"
        end
      end
  end
end
