require "makkamethods"
require "discordrb"

describe MakkaMethods do

  let(:makkachin) { Class.new { extend MakkaMethods } }
  let(:event) { double(:event) }
  let(:run_forest_run) { double(:role) }
  let(:sixpences) { double(:user) }
  let(:timer) { double(:sprinttimer) }

  describe "#commands_list" do
    it "should return a string listing commands" do
      expect(makkachin.commands_list).to be_a String
    end
  end

  describe "#role_getter" do
    it "should get the role object and assign it to a variable" do
      expect(makkachin.role_getter("role")).to eq "role"
    end
  end

  describe "#writing_sprint" do
    before do
      allow(timer).to receive(:run_forest_run) { double(:role) }
    end

    it "should only run one sprint at a time" do
      allow(makkachin).to receive(:timer) { timer }
      allow(timer).to receive(:ended) { false }
      expect { makkachin.writing_sprint(event) }.to raise_error "One sprint at a time!"
    end

    it "should create a new sprint timer and run it" do
      allow(makkachin).to receive(:sprinting_role) { run_forest_run }
      allow(event).to receive_message_chain("message.content.match.captures") { [0, 0] }
      allow(event).to receive(:respond) { "Get ready to sprint in 5 minutes" }
      allow(run_forest_run).to receive(:mention) { "@run forest run" }
      expect(makkachin.writing_sprint(event)).to eq true
    end
  end

  describe "#get_sprinters" do
    it "should return an error if no sprint is running" do
      allow(makkachin).to receive(:timer) { timer }
      allow(timer).to receive(:ended) { true }
      expect { makkachin.get_sprinters(event) }.to raise_error "No sprint is running"
    end

    it "should pass opting-in sprinters into the timer" do
      allow(event).to receive(:author) { sixpences }
      allow(makkachin).to receive(:timer) { timer }
      allow(timer).to receive(:ended) { false }
      allow(timer).to receive(:get_users_sprinting).with(event.author) { [event.author] }
      expect(makkachin.get_sprinters(event)).to eq [sixpences]
    end
  end

  describe "#permasprinters" do
    it "should assign the springing role to a user" do
      allow(sixpences).to receive(:add_role) { "run forest run" }
      expect(makkachin.permasprinters(sixpences)).to eq "run forest run"
    end
  end

  describe "#tired_sprinters" do
    it "should remove the sprinting role" do
      allow(sixpences).to receive(:remove_role) { "run forest run" }
      expect(makkachin.tired_sprinters(sixpences)).to eq "run forest run"
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
