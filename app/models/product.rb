class Product
  include Virtus.model

  attribute :code, String
  attribute :name, String
  attribute :subject_code, String

  class << self
    def all
      return @all if @all

      country_code = 'russia' # read from env
      hash = YAML.load_file("config/countries/#{country_code}/products.yaml")
      @all = hash['products'].map do |product_hash|
        Product.new(product_hash)
      end
    end

    def find_by_code(code)
      all.find { |p| p.code == code }
    end

    def find_by_code!(code)
      find_by_code(code) || raise(RuntimeError, "Product with code #{code} not found")
    end
  end

  def subject
    Subject.find_by_code(subject_code)
  end
end
