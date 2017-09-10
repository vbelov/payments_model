module Api
  module V1
    class BundleResource < JSONAPI::Resource
      attributes :name, :price, :items

      def items
        @model.items.map(&:to_h)
      end

      def items=(new_items)
        begin
          @model.set_items(new_items.map(&:to_unsafe_h))
        rescue Product::NotFound => err
          raise JSONAPI::Exceptions::InvalidFieldValue.new('product', err.product_code)
        rescue SubscriptionPeriod::NotFound => err
          raise JSONAPI::Exceptions::InvalidFieldValue.new('period', err.period_code)
        end
      end
    end
  end
end
