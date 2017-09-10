module Api
  module V1
    class SubscriptionPeriodResource < JSONAPI::Resource
      immutable
      primary_key :code
      key_type :string
      attributes :code, :name

      def self.default_sort
        []
      end

      def self.resource_type_for(model)
        'subscription_period'
      end

      filter :code, apply: ->(records, value, _options) {
        records.select { |r| r.code == value }
      }
    end
  end
end
