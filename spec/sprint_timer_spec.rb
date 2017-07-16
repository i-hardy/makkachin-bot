require "sprint_timer"
require "discordrb"

describe SprintTimer do
  let(:sixpences) { double(:user) }
  let(:run_forest_run) { double(:role) }
  subject(:timer) { described_class.new(5, 20, event) }

  describe "#role_setter" do
    it "should push the role into the users array" do
      expect(timer.role_setter("role")).to eq ["role"]
    end
  end

  it "responds to events" do
    VCR.use_cassette('discord') do
      event.respond "Woof"
    end
  end

  before do
    allow(run_forest_run).to receive(:mention) { "@run forest run" }
    allow(sixpences).to receive(:mention) { "@sixpences" }
  end

  describe "#set_start" do
    it "should run the sprinting process and set ended to true" do
      allow(timer).to receive(:sleep)
      allow(event).to receive(:respond) { "Get ready to sprint in 5 minutes" }
      expect(timer.set_start).to eq true
    end
  end

  describe "#sprint_starter" do
    it "should continue the sprinting process and set ended to true" do
      allow(timer).to receive(:sleep)
      allow(event).to receive(:respond) { "@run_forest_run @sixpences 20 minute sprint starts now!" }
      timer.get_users_sprinting(sixpences)
      expect(timer.sprint_starter).to eq true
    end
  end

  describe "#sprint_ender" do

    it "should end the sprint" do
      allow(event).to receive(:respond) { "@run_forest_run @sixpences Stop sprinting!" }
      timer.get_users_sprinting(sixpences)
      expect(timer.sprint_ender).to eq true
    end
  end

  it { is_expected.to respond_to(:get_users_sprinting).with(1).argument }

end
