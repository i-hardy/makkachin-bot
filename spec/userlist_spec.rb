require "userlist"

describe Userlist do
  let(:role) { double(:role) }
  let(:sixpences) { double(:user) }
  subject(:userlist) { described_class.new }

  describe "#get_users_sprinting" do
    it "should receive users opting in to a sprint" do
      expect(userlist.get_users_sprinting(sixpences)).to eq [sixpences]
    end
  end

  describe "#list" do
    it "should enclose a list of users opting in to sprint" do
      expect(subject.list).to be_a Array
    end
  end

  describe "#user_mentions" do
    it "should join the list into a string of mentions" do
      allow(sixpences).to receive(:mention) { "@sixpences" }
      userlist.get_users_sprinting(sixpences)
      expect(userlist.user_mentions).to eq "@sixpences"
    end
  end
end
