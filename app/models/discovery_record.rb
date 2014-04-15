require "json"

class DiscoveryRecord

  attr_reader :data

  def initialize(json_result)
    @data = json_result
  end


  def title
    data["display"]["title"].to_s.truncate(250, :separator => ' ')
  end


  def type
    data['type'].downcase
  end


  def creator_contributor
    data['display']['creator_contributor'].to_s.truncate(250, :separator => ' ')
  end


  def details
    data['display']['details'].to_s.truncate(250, :separator => ' ')
  end


  def publisher_provider
    data['display']['publisher_provider'].to_s.truncate(250, :separator => ' ')
  end


  def availability
    data['display']['availability']
  end


  def available_library
    data['display']['available_library']
  end


  def fulltext_available?
    data['fulltext_available']
  end


  def fulltext_url
    data['links']['fulltext_url']
  end

  def display_fields
    data['primo']['display']
  end


  private

    def self.make_request(id)
      API::Resource.search_catalog(id)
    end

end
