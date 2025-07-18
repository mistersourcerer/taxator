require "taxator/modalities"
require "taxator/purchase_item"

RSpec.describe Taxator::Modalities do
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
  let(:book) {
    Taxator::PurchaseItem.new(name: "amazing book of stuff", price: BigDecimal(12.49.to_s))
  }
  let(:medicine) {
    Taxator::PurchaseItem.new(name: "packet of headache pills", price: BigDecimal(9.75.to_s))
  }

  describe Taxator::Modalities::ImportTax do
    it "returns the right percentage for importing tax" do
      expect(subject.call(imported)).to eq 5
    end

    it "is #applicable to imported items" do
      expect(subject.applicable?(imported)).to eq true
      expect(subject.applicable?(imported_food)).to eq true
    end

    it "doesn't apply to other items" do
      expect(subject.applicable?(perfume)).to eq false
      expect(subject.applicable?(food)).to eq false
    end
  end

  describe Taxator::Modalities::SalesTax do
    it "returns the right percentage for sales tax" do
      expect(subject.call(perfume)).to eq 10
    end

    it "is #applicable to imported items" do
      expect(subject.applicable?(imported)).to eq true
    end

    it "is #applicable to non food, book or medicine items" do
      expect(subject.applicable?(perfume)).to eq true
    end

    it "doesn't apply to food, book or medicine" do
      check = [food, book, medicine].map { |item| subject.applicable?(item) }
      expect(check.uniq).to eq [false]
    end
  end
end
