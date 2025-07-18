module Taxator
  module Modalities
    class SalesTax
      def applicable?(item)
        @_dont_apply ||= ["chocolate", "pills", "book"]
        return false if @_dont_apply.map { |w| item.name.include?(w) }.any?(true)
        true
      end

      def call(item)
        10
      end
    end

    class ImportTax
      def applicable?(item)
        item.name.include?("imported")
      end

      def call(item)
        5
      end
    end
  end
end
