class AmazonStore
  cattr_accessor :options

  # Loads the configuration variables from application.yml file
  def self.init(config_file = 'config/application.yml')
    yaml = File.open(config_file) { |f| YAML::load(f) }['AWS']
    @@options = {}
    yaml.each {|key, value| @@options[key.to_sym] = value}
    
    # Response group medium to get more information like images
    @@options.merge! :response_group => 'Medium'
  end

  # Returns an array of hash with search results
  def self.search(title, page = 1)
    return WillPaginate::Collection.new(1, 10) if title.blank?
    self.init if options.nil? # Development mode only as Rails reloads classes
    
    results = Array.new
    # res = YAML.load(File.read('/tmp/kkk.yml'))
    res = Amazon::Ecs.item_search(title, @@options.merge(:item_page => page))
#    f = File.open("/tmp/kkk.yml", "w")
#    f.puts res.to_yaml
#    f.close
    
    res.items.each_with_index do |i, index|
      item = Hash.new
      item[:asin]         = i.get('ASIN').to_s
      item[:url]          = i.get('DetailPageURL').to_s
      item[:description]  = i.get('EditorialReviews/EditorialReview/Content')
      item[:smallimage]   = i.get('SmallImage/URL')
      item[:largeimage]   = i.get('LargeImage/URL')
      item[:format]       = i.get('ProductGroup')
      
      attrs = i.get_element('ItemAttributes')
      item[:title]        = attrs.get('Title')
      item[:actor]        = attrs.get_array('Actor')
      item[:director]     = attrs.get('Director')
      item[:manufacturer] = attrs.get('Manufacturer')
      item[:category]     = i.get('BrowseNodes/BrowseNode/Name') || "Autres"
      results << item
    end
    
    # Returns a Collection for pagination
    WillPaginate::Collection.create(page || 1, 10) do |pager|   
      pager.replace results
      pager.total_entries = res.total_pages * 10
    end
  end
end
