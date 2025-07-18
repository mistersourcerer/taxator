require "taxator/reader"

RSpec.describe Taxator::Reader do
  subject(:reader) { described_class }

  context "parsing the basic item structure" do
    it "knows the structure of a purchased item" do
      item = reader.new("1 chocolate bar at 0.85").read.first

      expect(item.amount).to eq 1
      expect(item.name).to eq "chocolate bar"
      expect(item.price).to eq BigDecimal(0.85.to_s)
    end

    it "handles multiple items" do
      str = "1 chocolate bar at 0.85\r\n"
      str << "1 imported box of chocolates at 10.00\r\n"
      items = reader.new(str).read

      expect(items.map(&:name)).to eq [
        "chocolate bar", "imported box of chocolates"
      ]
    end
  end

  context "happy path" do
    describe "from file" do
      it "reads items from a file" do
        items = reader.new(fixture_path("mixed")).read

        expect(items.size).to eq 6
        expect(items.map(&:name)).to eq [
          "music CD",
          "chocolate bar",
          "imported bottle of perfume",
          "bottle of perfume",
          "packet of headache pills",
          "imported boxes of chocolates"
        ]
      end
    end
  end
end
