require File.dirname(__FILE__) + '/../test_helper'

class HomeControllerTest < ActionController::TestCase
  context "get index" do
    setup do
      get :index
    end

    should_respond_with :success
  end
end
