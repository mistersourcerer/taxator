require "taxator/taxes"

module Taxator
  class Purchase
    private attr_reader :items

    def initialize(items)
      @items = items
    end

    def taxes
      @taxes ||= items.sum { |item| Taxes.new(item).calculate * item.amount }
    end

    def total
      @total ||= items.sum do |item|
        item.amount * (Taxes.new(item).calculate + item.price)
      end
    end
  end
end
