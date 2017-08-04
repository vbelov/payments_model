class Product
  include Virtus.model

  attribute :code, String

  class << self
    def all
      return @all if @all

      country_code = 'russia' # read from env
      hash = YAML.load_file("config/countries/#{country_code}/products.yaml")
      @all = hash['products'].map do |product_hash|
        Product.new(product_hash)
      end
    end
  end
end
