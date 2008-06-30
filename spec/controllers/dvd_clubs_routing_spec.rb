require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DvdClubsController do
  describe "route generation" do

    it "should map { :controller => 'dvd_clubs', :action => 'index' } to /dvd_clubs" do
      route_for(:controller => "dvd_clubs", :action => "index").should == "/dvd_clubs"
    end
  
    it "should map { :controller => 'dvd_clubs', :action => 'new' } to /dvd_clubs/new" do
      route_for(:controller => "dvd_clubs", :action => "new").should == "/dvd_clubs/new"
    end
  
    it "should map { :controller => 'dvd_clubs', :action => 'show', :id => 1 } to /dvd_clubs/1" do
      route_for(:controller => "dvd_clubs", :action => "show", :id => 1).should == "/dvd_clubs/1"
    end
  
    it "should map { :controller => 'dvd_clubs', :action => 'edit', :id => 1 } to /dvd_clubs/1/edit" do
      route_for(:controller => "dvd_clubs", :action => "edit", :id => 1).should == "/dvd_clubs/1/edit"
    end
  
    it "should map { :controller => 'dvd_clubs', :action => 'update', :id => 1} to /dvd_clubs/1" do
      route_for(:controller => "dvd_clubs", :action => "update", :id => 1).should == "/dvd_clubs/1"
    end
  
    it "should map { :controller => 'dvd_clubs', :action => 'destroy', :id => 1} to /dvd_clubs/1" do
      route_for(:controller => "dvd_clubs", :action => "destroy", :id => 1).should == "/dvd_clubs/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'dvd_clubs', action => 'index' } from GET /dvd_clubs" do
      params_from(:get, "/dvd_clubs").should == {:controller => "dvd_clubs", :action => "index"}
    end
  
    it "should generate params { :controller => 'dvd_clubs', action => 'new' } from GET /dvd_clubs/new" do
      params_from(:get, "/dvd_clubs/new").should == {:controller => "dvd_clubs", :action => "new"}
    end
  
    it "should generate params { :controller => 'dvd_clubs', action => 'create' } from POST /dvd_clubs" do
      params_from(:post, "/dvd_clubs").should == {:controller => "dvd_clubs", :action => "create"}
    end
  
    it "should generate params { :controller => 'dvd_clubs', action => 'show', id => '1' } from GET /dvd_clubs/1" do
      params_from(:get, "/dvd_clubs/1").should == {:controller => "dvd_clubs", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'dvd_clubs', action => 'edit', id => '1' } from GET /dvd_clubs/1;edit" do
      params_from(:get, "/dvd_clubs/1/edit").should == {:controller => "dvd_clubs", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'dvd_clubs', action => 'update', id => '1' } from PUT /dvd_clubs/1" do
      params_from(:put, "/dvd_clubs/1").should == {:controller => "dvd_clubs", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'dvd_clubs', action => 'destroy', id => '1' } from DELETE /dvd_clubs/1" do
      params_from(:delete, "/dvd_clubs/1").should == {:controller => "dvd_clubs", :action => "destroy", :id => "1"}
    end
  end
end
