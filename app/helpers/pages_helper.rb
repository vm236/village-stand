module PagesHelper

  def products_left_to_show(counter)
    if ((counter - 4) <= 0 )
      'More'
    else
      "#{counter - 4}" + ' More'
    end
  end

  class NotMyFarm < StandardError
    def message
      "This is not your farm!"
    end
  end
end
