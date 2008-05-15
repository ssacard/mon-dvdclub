require File.dirname(__FILE__) + '/../test_helper'

class AmazonStoreTest < ActiveSupport::TestCase
  # Replace this with your real tests.

  context "An AmazonStore" do

    setup do
      config = File.open('config/application.yml') { |f| YAML::load(f) }['AWS']
      @aws_access_key = config['aws_access_key']
      @aws_secret_access_key = config['aws_secret_access_key']
      @country = config['country']
      @search_index = config['search_index']
    end
  
    should "be initialized by default" do
      assert_not_equal AmazonStore.aws_access_key, nil
    end

    should "read a valid access key from application.yml" do
      assert_equal AmazonStore.aws_access_key, @aws_access_key
    end

    should "read a valid country from application.yml" do
      assert_equal AmazonStore.country, @country
    end

    should "read a valid secret access key from application.yml" do
      assert_equal AmazonStore.aws_secret_access_key, @aws_secret_access_key
    end

    should "read a valid search index from application.yml" do
      assert_equal AmazonStore.search_index, @search_index
    end

    should "search for DVD titles and return an array" do
      results = AmazonStore.search('Rock')
      assert_equal results.is_a?(Array), true
    end

    should "return an empty array if no search string is passed " do
      results = AmazonStore.search("")
      assert_equal results.is_a?(Array), true
      assert_equal results.length, 0
    end
  end

end
