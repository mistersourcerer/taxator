require "taxator/modalities"

module Taxator
  class Taxes
    TAXES = [Modalities::SalesTax, Modalities::ImportTax].map(&:new)
    private attr_reader :item, :taxes

    def initialize(item)
      @item = item
      @taxes = applicable_taxes
    end

    def calculate
      taxes.reduce(0) { |sum, tax| sum + apply(tax.call(item), item.price) }
    end

    private

    def applicable_taxes
      TAXES.select { |tax| tax.applicable?(item) }
    end

    def apply(perc, price)
      @_nearest ||= BigDecimal(0.05.to_s)
      tax = (perc * price.to_d) / 100
      (tax / @_nearest).ceil * @_nearest
    end
  end
end
