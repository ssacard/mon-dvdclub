require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClubTopic do
  before(:each) do
    @club_topic = ClubTopic.new
  end

  it "should be valid" do
    @club_topic.should be_valid
  end
end
