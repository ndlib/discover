require "json"

class DiscoveryRecord

  attr_reader :data

  def initialize(json_result)
    @data = json_result
    log_unknown_display_fields
  end

  def log_unknown_display_fields
    if data
      LogUnknownDisplayFields.call(self)
    end
  end

  def id
    data["id"]
  end


  def title
    data["display"]["title"]
  end


  def type
    data['type'].downcase
  end


  def creator_contributor
    data['display']['creator_contributor']
  end


  def details
    data['display']['details']
  end


  def publisher_provider
    data['display']['publisher_provider']
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
    primo['display']
  end


  private

    def self.make_request(id)
      API::Resource.search_catalog(id)
    end

    def primo
      data['primo'] || {}
    end

end
