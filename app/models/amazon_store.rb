class AmazonStore
  cattr_accessor :options

  # Loads the configuration variables from application.yml file
  def self.init(config_file = 'config/application.yml')
    yaml = File.open(config_file) { |f| YAML::load(f) }['AWS']
    @@options = {}
    yaml.each {|key, value| @@options[key.to_sym] = value}
    @@options.merge! :response_group => 'Medium'
  end

  # Returns an array of hash with search results
  def self.search(title, page = 1)
    # For development mode
    self.init if options.nil?

    return [] if title.blank?
    
    
    results = Array.new
    res = Amazon::Ecs.item_search(title, @@options.merge(:item_page => page))

    res.items.each do |i|
      item = Hash.new
      item[:asin]         = i.get('asin').to_s
      item[:url]          = i.get('detailpageurl').to_s
      item[:image]        = i.get('smallimage/url')
      
      attrs = i.search_and_convert('itemattributes')
      item[:title]        = attrs.get('title')
      item[:actor]        = attrs.get_array('actor')
      item[:director]     = attrs.get('director')
      item[:manufacturer] = attrs.get('manufacturer')
      results << item
    end
    
    WillPaginate::Collection.create(page || 1, 10) do |pager|   
      pager.replace results
      pager.total_entries = res.total_pages * 10
    end
  end
end
