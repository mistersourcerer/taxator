require "taxator/taxes"

RSpec.describe Taxator::Taxes do
  subject(:taxes) { described_class }

  let(:imported) {
    Taxator::PurchaseItem.new(name: "imported perfume", price: BigDecimal(47.50.to_s))
  }
  let(:perfume) {
    Taxator::PurchaseItem.new(name: "perfume", price: BigDecimal(18.99.to_s))
  }
  let(:imported_food) {
    Taxator::PurchaseItem.new(name: "imported box of chocolates", price: BigDecimal(10.0.to_s))
  }
  let(:food) {
    Taxator::PurchaseItem.new(name: "chocolate bar", price: BigDecimal(0.85.to_s))
  }

  describe "#calculate" do
    it "imported 'common' products" do
      expect(taxes.new(imported).calculate).to eq BigDecimal(7.15.to_s)
    end

    it "non-imported 'common' products" do
      expect(taxes.new(perfume).calculate).to eq BigDecimal(1.90.to_s)
    end

    it "exempt imported items" do
      expect(taxes.new(imported_food).calculate).to eq BigDecimal(0.50.to_s)
    end

    it "exempt 'common' items" do
      expect(taxes.new(food).calculate).to eq 0
    end
  end
end
