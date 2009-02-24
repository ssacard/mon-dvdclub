class AmazonStore
  cattr_accessor :options

  # Loads the configuration variables from application.yml file
  def self.init(config_file = 'config/application.yml')
    yaml = File.open(config_file) { |f| YAML::load(f) }['AWS']
    @@options = {}
    yaml.each {|key, value| @@options[key.to_sym] = value}
    
    # Response group meduim to get more information like images
    @@options.merge! :response_group => 'Large'
  end

  # Returns an array of hash with search results
  def self.search(title, page = 1)
    return WillPaginate::Collection.new(1, 10) if title.blank?
    self.init if options.nil? # Development mode only as Rails reloads classes
    
    results = Array.new
    # res = YAML.load(File.read('/tmp/kkk.yml'))
    res = Amazon::Ecs.item_search(title, @@options.merge(:item_page => page))
    f = File.open("/tmp/kkk.yml", "w")
    f.puts res.to_yaml
    f.close
    
    res.items.each_with_index do |i, index|
      item = Hash.new
      item[:asin]         = i.get('asin').to_s
      item[:url]          = i.get('detailpageurl').to_s
      item[:description]  = i.get('editorialreviews/editorialreview/content')
      item[:smallimage]   = i.get('smallimage/url')
      item[:largeimage]   = i.get('largeimage/url')
      item[:format]       = i.get('productgroup')
      
      attrs = i.search_and_convert('itemattributes')
      item[:title]        = attrs.get('title')
      item[:actor]        = attrs.get_array('actor')
      item[:director]     = attrs.get('director')
      item[:manufacturer] = attrs.get('manufacturer')
      item[:category]     = i.get('browsenodes/browsenode/name') || "Autres"
      results << item
    end
    
    # Returns a Collection for pagination
    WillPaginate::Collection.create(page || 1, 10) do |pager|   
      pager.replace results
      pager.total_entries = res.total_pages * 10
    end
  end
end
