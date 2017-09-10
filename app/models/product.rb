class Product
  include Virtus.model

  attribute :code, String
  attribute :name, String
  attribute :subject_code, String

  class NotFound < RuntimeError
    attr_reader :product_code

    def initialize(message, code)
      super(message)
      @product_code = code
    end
  end

  class << self
    def all
      return @all if @all

      country_code = 'russia' # read from env
      hash = YAML.load_file("config/countries/#{country_code}/products.yaml")
      @all = hash['products'].map do |product_hash|
        code = product_hash['code']
        game = product_hash['subject_code'].blank?
        begin
          klass = "products/#{code}".classify.constantize
        rescue NameError
          class_name = code.classify
          klass = Class.new(Product) do
            include Products::Game if game
          end
          Products.const_set(class_name, klass)
        end

        klass.new(product_hash)
      end
    end

    def find_by_code(code)
      all.find { |p| p.code == code }
    end

    def find_by_code!(code)
      find_by_code(code) || raise(NotFound.new("Product with code #{code} not found", code))
    end
  end

  def subject
    Subject.find_by_code(subject_code)
  end

  def game?
    is_a?(Products::Game)
  end
end
