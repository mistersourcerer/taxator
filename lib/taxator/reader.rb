require "stringio"
require "taxator/purchase_item"

module Taxator
  class Reader
    private attr_reader :io

    def initialize(str)
      @io =
        if !str.is_a?(IO) && !str.is_a?(StringIO)
          File.exist?(str) ? File.open(str, "r") : StringIO.new(str)
        else
          str
        end
    end

    def read
      @items = []

      until io.eof?
        item = PurchaseItem.new

        amount = ""
        c = io.getc
        while c != "\s"
          amount << c
          c = io.getc
        end
        item.amount = amount.to_i
        item.name = io.gets(" at ", chomp: true)
        item.price = io.gets.chomp.to_d

        @items << item
      end

      @items
    end
  end
end
