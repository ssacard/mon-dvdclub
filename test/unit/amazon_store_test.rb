require File.dirname(__FILE__) + '/../test_helper'

class AmazonStoreTest < ActiveSupport::TestCase
  # Replace this with your real tests.

  context "An AmazonStore" do
    setup do
      config = File.open('config/application.yml') { |f| YAML::load(f) }['AWS']
      @aws_access_key_id     = config['aWS_access_key_id']
      @country               = config['country']
      @search_index          = config['search_index']
    end
  
    should "be initialized by default" do
      assert_not_equal AmazonStore.options[:aWS_access_key_id], nil
    end

    should "read a valid access key from application.yml" do
      assert_equal AmazonStore.options[:aWS_access_key_id], @aws_access_key_id
    end

    should "read a valid country from application.yml" do
      assert_equal AmazonStore.options[:country], @country
    end

    # should "read a valid secret access key from application.yml" do
    #   assert_equal AmazonStore.options[:aws_secret_access_key], @aws_secret_access_key
    # end

    should "read a valid search index from application.yml" do
      assert_equal AmazonStore.options[:search_index], @search_index
    end

    should "search for DVD titles and return an array" do
      results = AmazonStore.search('Rock')
      assert_equal results.is_a?(WillPaginate::Collection), true
    end

    should "return an empty array if no search string is passed " do
      results = AmazonStore.search("")
      assert_equal results.is_a?(WillPaginate::Collection), true
      assert_equal results.length, 0
    end
  end

end
