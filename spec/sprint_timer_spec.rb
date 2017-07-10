require "sprint_timer"
require "discordrb"

describe SprintTimer do
  let(:event) { double(:event) }
  let(:sixpences) { double(:user) }
  let(:run_forest_run) { double(:role) }
  subject(:timer) { described_class.new(5, 20, event) }

  describe "#set_start" do
    it "should announce an upcoming sprint" do
      allow(timer).to receive(:sleep)
      allow(event).to receive(:respond) { "Get ready to sprint in 5 minutes" }
      expect(timer.set_start).to eq "Get ready to sprint in 5 minutes"
    end
  end

  describe "#sprint_starter" do
    before do
      allow(run_forest_run).to receive(:mention) { "@run_forest_run"}
    end

    it "should announce the start of a sprint" do
      allow(event).to receive(:respond) { "@run_forest_run @sixpences 20 minute sprint starts now!" }
      timer.get_users_sprinting(sixpences)
      expect(timer.sprint_starter).to eq "@run_forest_run @sixpences 20 minute sprint starts now!"
    end
  end

  describe "#sprint_ender" do
    before do
      allow(run_forest_run).to receive(:mention) { "@run_forest_run"}
    end
    
    it "should announce the end of a sprint" do
      allow(event).to receive(:respond) { "@user1, @user1 Stop sprinting!" }
      2.times { timer.get_users_sprinting("user1") }
      expect(timer.sprint_ender).to eq "@user1, @user1 Stop sprinting!"
    end
  end

  it { is_expected.to respond_to(:get_users_sprinting).with(1).argument }

end
