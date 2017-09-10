module Api
  module V1
    class ProductResource < JSONAPI::Resource
      immutable
      primary_key :code
      key_type :string
      attributes :code, :name, :subject_code

      def self.default_sort
        []
      end

      def self.resource_type_for(model)
        'product'
      end

      filter :code, apply: ->(records, value, _options) {
        records.select { |r| r.code == value }
      }
    end
  end
end
