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

  def contributor
    ensure_array(display_field(:contributor))
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
    ensure_array(display_field(:lds01))
  end


  def series
    ensure_array(display_field(:lds30))
  end


  def description
    display_field(:description)
  end


  def contents
    contents = display_field(:lds03)
    contents = split_row(contents)

    ensure_array(contents)
  end

  def published
    ret = []
    ret << display_field(:edition) if display_field(:edition)
    ret << display_field(:publisher) if display_field(:publisher)
    ret << display_field(:creationdate) if display_field(:creationdate)
    if display_field(:format)
      ret.concat(ensure_array(display_field(:format)))
    end

    ret
  end

  def record_ids
    ensure_array(display_field(:lds02))
  end

  def identifier
    display_field(:identifier)
  end

  def subjects
    ensure_array(display_field(:subject))
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


    def ensure_array(result)
      if result.nil?
        []
      elsif !result.is_a?(Array)
        result = [result]
      else
        result
      end
    end


    def split_row(row)
      if row.present?
        row.split("--").collect{ | r | r.to_s.strip }
      else
        row
      end
    end
end
