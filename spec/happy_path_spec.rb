require "debug"
ROOT = File.expand_path("../..", __FILE__)

RSpec.describe "CLI happy path" do
  def path_to(file)
    File.join(ROOT, file)
  end

  context "checking against samples" do
    it "works against sample 1" do
      out = `"#{path_to("exe/taxator")}" "#{path_to("spec/fixtures/input1")}"`
      expect(out).to eq fixture("output1")
    end

    it "works against sample 2" do
      out = `"#{path_to("exe/taxator")}" "#{path_to("spec/fixtures/input2")}"`
      expect(out).to eq fixture("output2")
    end

    it "works against sample 3" do
      out = `"#{path_to("exe/taxator")}" "#{path_to("spec/fixtures/input3")}"`
      expect(out).to eq fixture("output3")
    end
  end
end
