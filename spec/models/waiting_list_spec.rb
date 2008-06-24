require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WaitingList do
  before(:each) do
    @waiting_list = WaitingList.new
  end

  it "should be valid" do
    @waiting_list.should be_valid
  end
end
