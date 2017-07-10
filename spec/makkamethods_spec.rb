require "makkamethods"
require "discordrb"

describe MakkaMethods do

  let(:makkachin) { Class.new { extend MakkaMethods } }
  let(:event) { double(:event) }
  let(:run_forest_run) { double(:role) }
  let(:sixpences) { double(:user) }

  describe "#writing_sprint" do
    before do
      allow(run_forest_run).to receive(:mention) { "@run_forest_run"}
    end

    it "should only run one sprint at a time" do
      allow(run_forest_run).to receive(:mention) { "@run_forest_run"}
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
  end

  describe "#permasprinters" do
    it "should raise an error if a user already has the sprinting role" do
      allow(sixpences).to receive(:roles?).and_return true
      expect { makkachin.permasprinters(sixpences) }.to raise_error "User's stamina is already impressive"
    end
  end

  describe "#tired_sprinters" do
    it "should raise an error if the user does not have the sprinting role" do
      allow(sixpences).to receive(:roles?).and_return false
      expect { makkachin.tired_sprinters(sixpences) }.to raise_error "User is already tired"
    end
  end

  describe "#buns" do
    it "should tell you her opinion on steamed buns" do
      expect(makkachin.buns).to eq "NOM <:makkabuns:331514484378042368>"
    end
  end

  describe "#giphy_fetcher" do
    it "should return a string that is a gif url" do
      expect(makkachin.giphy_fetcher("cat")).to match(/(http).+(.gif)/)
    end
  end

end
