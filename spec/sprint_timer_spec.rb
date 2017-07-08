require "sprint_timer"
require "discordrb"

describe SprintTimer do
  let(:event) { double(:event) }
  subject { SprintTimer.new(5, 20, event) }

  describe "#set_start" do
    it "should announce an upcoming sprint" do
      allow(subject).to receive(:sleep)
      expect(subject.set_start).to eq "Get ready to sprint in 5 minutes"
    end
  end

  describe "#sprint_starter" do
    it "should announce the start of a sprint" do
      allow(subject).to receive(:sleep)
      allow(event).to receive(:respond) { "@user1, @user1 20 minute sprint starts now!" }
      2.times { subject.get_users_sprinting("user1") }
      expect(subject.sprint_starter).to eq "@user1, @user1 20 minute sprint starts now!"
    end
  end

  describe "#sprint" do
    it "should run for a specified time" do

    end
  end

  describe "#sprint_ender" do
    it "should announce the end of a sprint" do
      allow(event).to receive(:respond) { "@user1, @user1 Stop sprinting!" }
      2.times { subject.get_users_sprinting("user1") }
      expect(subject.sprint_ender).to eq "@user1, @user1 Stop sprinting!"
    end
  end

  it { is_expected.to respond_to(:get_users_sprinting).with(1).argument }

  describe "#get_users_sprinting" do
    it "should pass the usernames it is given into @users" do
      3.times { subject.get_users_sprinting("user1") }
      expect(subject.users).to eq ["user1", "user1", "user1"]
    end
  end

end
