module MetaValidation 
  module ClassMethods

    private

      def create_scope_methods
        inclusion_validators.each do |v| 
          v.options[:in].each do |content|
            scope(build_scope_name(v.attributes.first, content), lambda { where("#{v.attributes.first} = ? ", "#{content}") })
          end
        end
      end

      def build_scope_name(column, name)
        if configuration[:scoped]
          "#{column.to_s.pluralize}_#{name.pluralize}"
        else
          name.pluralize
        end
      end
  end
end
