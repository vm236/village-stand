module CartsHelper
  class NotMyCart < StandardError
    def message
      "This is not your cart!"
    end
  end
end
