require "taxator/purchase"

RSpec.describe Taxator::Purchase do
  let(:imported) {
    Taxator::PurchaseItem.new(
      amount: 1,
      name: "imported bottle of perfume",
      price: BigDecimal(27.99.to_s)
    )
  }

  let(:common) {
    Taxator::PurchaseItem.new(
      amount: 1,
      name: "bottle of perfume",
      price: BigDecimal(18.99.to_s)
    )
  }

  let(:exempt) {
    Taxator::PurchaseItem.new(
      amount: 1,
      name: "packet of headache pills",
      price: BigDecimal(9.75.to_s)
    )
  }

  let(:imported_exempt) {
    Taxator::PurchaseItem.new(
      amount: 3,
      name: "imported box of chocolates",
      price: BigDecimal(11.25.to_s)
    )
  }

  subject(:purchase) {
    described_class.new([
      imported, common, exempt, imported_exempt
    ])
  }

  describe "#taxes" do
    it "sums up all the taxes" do
      expect(purchase.taxes).to eq 7.90
    end
  end

  describe "#total" do
    it "sums up all the prices" do
      expect(purchase.total).to eq 98.38
    end
  end
end
