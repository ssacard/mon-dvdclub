require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserDvdClubsController do
  describe "route generation" do

    it "should map { :controller => 'user_dvd_clubs', :action => 'index' } to /user_dvd_clubs" do
      route_for(:controller => "user_dvd_clubs", :action => "index").should == "/user_dvd_clubs"
    end
  
    it "should map { :controller => 'user_dvd_clubs', :action => 'new' } to /user_dvd_clubs/new" do
      route_for(:controller => "user_dvd_clubs", :action => "new").should == "/user_dvd_clubs/new"
    end
  
    it "should map { :controller => 'user_dvd_clubs', :action => 'show', :id => 1 } to /user_dvd_clubs/1" do
      route_for(:controller => "user_dvd_clubs", :action => "show", :id => 1).should == "/user_dvd_clubs/1"
    end
  
    it "should map { :controller => 'user_dvd_clubs', :action => 'edit', :id => 1 } to /user_dvd_clubs/1/edit" do
      route_for(:controller => "user_dvd_clubs", :action => "edit", :id => 1).should == "/user_dvd_clubs/1/edit"
    end
  
    it "should map { :controller => 'user_dvd_clubs', :action => 'update', :id => 1} to /user_dvd_clubs/1" do
      route_for(:controller => "user_dvd_clubs", :action => "update", :id => 1).should == "/user_dvd_clubs/1"
    end
  
    it "should map { :controller => 'user_dvd_clubs', :action => 'destroy', :id => 1} to /user_dvd_clubs/1" do
      route_for(:controller => "user_dvd_clubs", :action => "destroy", :id => 1).should == "/user_dvd_clubs/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'user_dvd_clubs', action => 'index' } from GET /user_dvd_clubs" do
      params_from(:get, "/user_dvd_clubs").should == {:controller => "user_dvd_clubs", :action => "index"}
    end
  
    it "should generate params { :controller => 'user_dvd_clubs', action => 'new' } from GET /user_dvd_clubs/new" do
      params_from(:get, "/user_dvd_clubs/new").should == {:controller => "user_dvd_clubs", :action => "new"}
    end
  
    it "should generate params { :controller => 'user_dvd_clubs', action => 'create' } from POST /user_dvd_clubs" do
      params_from(:post, "/user_dvd_clubs").should == {:controller => "user_dvd_clubs", :action => "create"}
    end
  
    it "should generate params { :controller => 'user_dvd_clubs', action => 'show', id => '1' } from GET /user_dvd_clubs/1" do
      params_from(:get, "/user_dvd_clubs/1").should == {:controller => "user_dvd_clubs", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'user_dvd_clubs', action => 'edit', id => '1' } from GET /user_dvd_clubs/1;edit" do
      params_from(:get, "/user_dvd_clubs/1/edit").should == {:controller => "user_dvd_clubs", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'user_dvd_clubs', action => 'update', id => '1' } from PUT /user_dvd_clubs/1" do
      params_from(:put, "/user_dvd_clubs/1").should == {:controller => "user_dvd_clubs", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'user_dvd_clubs', action => 'destroy', id => '1' } from DELETE /user_dvd_clubs/1" do
      params_from(:delete, "/user_dvd_clubs/1").should == {:controller => "user_dvd_clubs", :action => "destroy", :id => "1"}
    end
  end
end
