require "userlist"

describe Userlist do
  let(:role) { double(:role) }
  let(:sixpences) { double(:user) }
  subject(:userlist) { described_class.new(role) }

  describe "initialization" do
    it "should receive a role at initialization and add it to the user list" do
      expect(subject.list).to eq [role]
    end
  end

  describe "#get_users_sprinting" do
    it "should receive users opting in to a sprint" do
      expect(userlist.get_users_sprinting(sixpences)).to eq [role, sixpences]
    end
  end

  describe "#list" do
    it "should enclose a list of users opting in to sprint" do
      expect(subject.list).to be_a Array
    end
  end

  describe "#mention" do
    it "should join the list into a string of mentions"
  end
end
