require "makkamethods"

describe MakkaMethods do

  let(:makkachin) { Class.new { extend MakkaMethods } }
  let(:event) { Object.new { include Discordrb } }

  describe "#writing_sprint" do

  end

  describe "#buns" do
    it "should tell you her opinion on steamed buns" do
      expect(makkachin.buns).to eq "NOM <:makkabuns:331514484378042368>"
    end
  end

end
