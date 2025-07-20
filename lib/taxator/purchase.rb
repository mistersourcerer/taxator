require "taxator/purchase_item"
require "taxator/reader"
require "taxator/taxes"

module Taxator
  class Purchase
    private attr_reader :items

    class << self
      def from_file(file_path)
        raise "file not found: #{file_path}" if(!File.exist?(file_path))
        new Taxator::Reader.new(file_path).read
      end
    end

    def initialize(items)
      @items = items
    end

    def taxes
      @taxes ||= items.sum { |item| Taxes.new(item).calculate * item.amount }
    end

    def total
      @total ||= items.sum do |item|
        @subtotals ||= []
        subtotal = item.amount * (Taxes.new(item).calculate + item.price)
        @subtotals << {item: item, subtotal: subtotal}
        subtotal
      end
    end

    def subtotals
      @subtotals ||= total && @subtotals
    end
  end
end
