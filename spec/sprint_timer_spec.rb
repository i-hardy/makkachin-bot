require "sprint_timer"
require "discordrb"

describe SprintTimer do
  let(:userlist) { double(:userlist) }
  let(:event) { double(:event) }
  subject(:timer) { described_class.new(5, 20, event) }

  before do
    allow(timer).to receive(:sleep)
    allow(userlist).to receive(:user_mentions) { "@run forest run @sixpences" }
  end

  describe "#set_start" do
    it "should create a respond event" do
      expect(event).to receive(:respond).exactly(3).times
      timer.set_start
    end

    it "should call the sprint_starter method" do
      allow(event).to receive(:respond)
      expect(timer).to receive(:sprint_starter)
      timer.set_start
    end
  end

  describe "#sprint_starter" do
    it "should announce the start of the sprint" do
      expect(event).to receive(:respond).twice
      timer.sprint_starter
    end

    it "should start the actual sprint" do
      allow(event).to receive(:respond)
      expect(timer).to receive(:sprint)
      timer.sprint_starter
    end
  end

  describe "#sprint_ender" do
    it "should announce the end of the spring" do
      expect(event).to receive(:respond).with(" Stop sprinting!")
      timer.sprint_ender
    end

    it "should end the sprint" do
      allow(event).to receive(:respond)
      timer.sprint_ender
      expect(timer).to be_ended
    end
  end

  describe "#ended?" do
    it "returns false if the timer is running" do
      expect(timer).not_to be_ended
    end
  end
end
