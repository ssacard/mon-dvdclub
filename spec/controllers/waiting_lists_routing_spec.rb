require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WaitingListsController do
  describe "route generation" do

    it "should map { :controller => 'waiting_lists', :action => 'index' } to /waiting_lists" do
      route_for(:controller => "waiting_lists", :action => "index").should == "/waiting_lists"
    end
  
    it "should map { :controller => 'waiting_lists', :action => 'new' } to /waiting_lists/new" do
      route_for(:controller => "waiting_lists", :action => "new").should == "/waiting_lists/new"
    end
  
    it "should map { :controller => 'waiting_lists', :action => 'show', :id => 1 } to /waiting_lists/1" do
      route_for(:controller => "waiting_lists", :action => "show", :id => 1).should == "/waiting_lists/1"
    end
  
    it "should map { :controller => 'waiting_lists', :action => 'edit', :id => 1 } to /waiting_lists/1/edit" do
      route_for(:controller => "waiting_lists", :action => "edit", :id => 1).should == "/waiting_lists/1/edit"
    end
  
    it "should map { :controller => 'waiting_lists', :action => 'update', :id => 1} to /waiting_lists/1" do
      route_for(:controller => "waiting_lists", :action => "update", :id => 1).should == "/waiting_lists/1"
    end
  
    it "should map { :controller => 'waiting_lists', :action => 'destroy', :id => 1} to /waiting_lists/1" do
      route_for(:controller => "waiting_lists", :action => "destroy", :id => 1).should == "/waiting_lists/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'waiting_lists', action => 'index' } from GET /waiting_lists" do
      params_from(:get, "/waiting_lists").should == {:controller => "waiting_lists", :action => "index"}
    end
  
    it "should generate params { :controller => 'waiting_lists', action => 'new' } from GET /waiting_lists/new" do
      params_from(:get, "/waiting_lists/new").should == {:controller => "waiting_lists", :action => "new"}
    end
  
    it "should generate params { :controller => 'waiting_lists', action => 'create' } from POST /waiting_lists" do
      params_from(:post, "/waiting_lists").should == {:controller => "waiting_lists", :action => "create"}
    end
  
    it "should generate params { :controller => 'waiting_lists', action => 'show', id => '1' } from GET /waiting_lists/1" do
      params_from(:get, "/waiting_lists/1").should == {:controller => "waiting_lists", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'waiting_lists', action => 'edit', id => '1' } from GET /waiting_lists/1;edit" do
      params_from(:get, "/waiting_lists/1/edit").should == {:controller => "waiting_lists", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'waiting_lists', action => 'update', id => '1' } from PUT /waiting_lists/1" do
      params_from(:put, "/waiting_lists/1").should == {:controller => "waiting_lists", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'waiting_lists', action => 'destroy', id => '1' } from DELETE /waiting_lists/1" do
      params_from(:delete, "/waiting_lists/1").should == {:controller => "waiting_lists", :action => "destroy", :id => "1"}
    end
  end
end
