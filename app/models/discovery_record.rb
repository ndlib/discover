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
    display_field(:title)
  end

  def type
    display_field(:type)
  end

  def creator
    display_field(:creator)
  end

  def description
    display_field(:description)
  end

  def availability
    display_field(:availpnx)
  end

  def language
    display_field(:language)
  end

  def general_notes
    display_field(:lds01)
  end

  def description
    display_field(:description)
  end

  def edition
    display_field(:edition)
  end

  def publisher
    display_field(:publisher)
  end

  def creation_date
    display_field(:creationdate)
  end

  def format
    display_field(:format)
  end

  def record_ids
    display_field(:lds02)
  end

  def identifier
    display_field(:identifier)
  end

  def subjects
    display_field(:subject)
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

    def display_field(key)
      display_fields[key.to_s]
    end

end
