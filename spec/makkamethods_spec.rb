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
    let(:timer) { double(:sprinttimer) }
    it "should return an error if no sprint is running" do
      expect { makkachin.get_sprinters(event) }.to raise_error "No sprint is running"
    end

    it "should pass usernames into the currently running instance of SprintTimer" do
      allow(timer).to receive(:set_start)
      timer.set_start

    end
  end

  describe "#permasprinters" do
    it "should raise an error if a user is already on the permasprinters list" do
      expect { makkachin.permasprinters("sixpences") }.to raise_error "User's stamina is already impressive"
    end

    it "should return a saved CSV file" do
      expect(makkachin.permasprinters("newuser")).to be_a CSV
    end
  end

  describe "#tired_sprinters" do
    it "should raise an error if the username passed is not on the permasprinters list" do
      expect { makkachin.tired_sprinters("notonlist") }.to raise_error "User is already tired"
    end

    it "should return an altered CSV file" do
      expect(makkachin.permasprinters("sixpences")).to be_a CSV
    end
  end

  describe "#buns" do
    it "should tell you her opinion on steamed buns" do
      expect(makkachin.buns).to eq "NOM <:makkabuns:331514484378042368>"
    end
  end

  describe "#giphy_fetcher" do
    it "should return a string that is a gif url" do
      expect(makkachin.giphy_fetcher("cat")).to be_a String
    end
  end

end
