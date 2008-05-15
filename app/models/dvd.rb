class Dvd < ActiveRecord::Base
	has_and_belongs_to_many :directors
	has_and_belongs_to_many :manufacturers, :join_table => 'manufacturers_dvds'
	has_and_belongs_to_many :actors, :join_table => 'dvds_actors'
	validates_presence_of :title

  def self.create_record(attrs)
    dvd = Dvd.create!(:asin => attrs['asin'], :details_url => attrs['url'], :title => attrs['title'])
    if attrs['manufacturer']
      manufacturer = Manufacturer.find_or_create_by_name(attrs['manufacturer']) 
      dvd.manufacturers << manufacturer
    end
    if attrs['director']
      director     = Director.find_or_create_by_name(attrs['director'])
      dvd.directors     << director    
    end
    
    attrs["actors"].each do |actor|
      a = Actor.find_or_create_by_name(actor)
      dvd.actors << a
    end
    rescue
      false 
  end

end
