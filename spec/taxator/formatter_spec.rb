require "taxator/formatter"

RSpec.describe Taxator::Formatter::CLI do
  subject(:formatter) { described_class.new }
  def purchase_with(file)
    Taxator::Purchase.from_file fixture_path(file)
  end

  describe "#format" do
    it("generates a formatted output adequate for CLI") do
      purchase = purchase_with("input1")

      expect(formatter.call(purchase)).to eq [
        "2 book: 24.98",
        "1 music CD: 16.49",
        "1 chocolate bar: 0.85",
        "Sales Taxes: 1.50",
        "Total: 42.32",
      ].join("\n")
    end
  end
end
