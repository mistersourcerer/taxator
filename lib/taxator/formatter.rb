module Taxator
  module Formatter
    class CLI
      def call(purchase)
        items = purchase.subtotals.reduce([]) do |arr, subtotal|
          item = subtotal[:item]
          value = subtotal[:subtotal]
          arr << "#{item.amount} #{item.name}: #{money(value)}"
        end
        taxes = "Sales Taxes: #{money(purchase.taxes)}"
        total = "Total: #{money(purchase.total)}"

        [items.join("\n"), taxes, total].join("\n")
      end

      private

      def money(bigdecimal)
        "%.2f" % bigdecimal
      end
    end
  end
end
