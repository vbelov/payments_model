module Products
  class Chocolate < ::Product
    include Game

    def unique_chocolate_method; end
  end
end
