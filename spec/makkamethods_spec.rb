require "makkamethods"
require "discordrb"

describe MakkaMethods do

  let(:makkachin) { Class.new { extend MakkaMethods } }
  let(:event) { double(:event) }

  describe "#writing_sprint" do
    it "should only run one sprint at a time" do
      allow(event).to receive(:message)
      allow(event.message).to receive(:content) { "!sprint in 0 for 0" }
      allow(event).to receive(:respond)
      makkachin.writing_sprint(event)
      expect { makkachin.writing_sprint(event) }.to raise_error "One sprint at a time!"
    end
  end

  describe "#get_sprinters" do
    it "should return an error if no sprint is running" do
      expect { makkachin.get_sprinters(event) }.to raise_error "No sprint is running"
    end

    it "should pass usernames into the currently running timer" do

    end
  end

  describe "#buns" do
    it "should tell you her opinion on steamed buns" do
      expect(makkachin.buns).to eq "NOM <:makkabuns:331514484378042368>"
    end
  end

end
