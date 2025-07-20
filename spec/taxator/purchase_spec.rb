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

  describe "#from_file" do
    it "creates a purchase based on a purchase file" do
      purchase = described_class.from_file(fixture_path("input3"))

      expect(purchase.subtotals.map { |tuple| tuple[:item].name }).to eq([
        "imported bottle of perfume",
        "bottle of perfume",
        "packet of headache pills",
        "imported boxes of chocolates"
      ])
      expect(purchase.total).to eq BigDecimal(98.38.to_s)
    end
  end

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

  describe "#subtotals" do
    it "separates subtotals per item" do
      expect(purchase.subtotals).to eq [
        {item: imported, subtotal: BigDecimal(32.19.to_s)},
        {item: common, subtotal: BigDecimal(20.89.to_s)},
        {item: exempt, subtotal: BigDecimal(9.75.to_s)},
        {item: imported_exempt, subtotal: BigDecimal(35.55.to_s)},
      ]
    end
  end
end
