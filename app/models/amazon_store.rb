class AmazonStore

  # Loads the configuration variables from application.yml file

  def self.init(config_file = 'config/application.yml')
    config = File.open(config_file) { |f| YAML::load(f) }['AWS']
    @aws_access_key = config['aws_access_key']
    @aws_secret_access_key = config['aws_secret_access_key']
    @country = config['country']
    @search_index = config['search_index']
  end

  # call initializer by default

  self.init

  # Getter for aws_access_key

  def self.aws_access_key
    @aws_access_key
  end

  def self.aws_secret_access_key
    @aws_secret_access_key    
  end

  def self.country
    @country   
  end

  def self.search_index
    @search_index    
  end


  # Returns an array of hash with search results

  def self.search(title)
    return [] unless !title.blank?
    results = Array.new
    res = Amazon::Ecs.item_search(title, :AWS_access_key_id => @aws_access_key, :country => @country, :search_index => @search_index)
    res.items.each do |i|
      item = Hash.new
      attrs = i.search_and_convert('itemattributes')
      item['asin']  = i.get('asin').to_s
      item['url']   = i.get('detailpageurl').to_s
      item['title'] = attrs.get('title')
      item['actor'] = attrs.get_array('actor')
      item['director'] = attrs.get('director')
      item['manufacturer'] = attrs.get('manufacturer')
      results << item
    end
    results
  end
end
