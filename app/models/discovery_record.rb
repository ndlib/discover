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
    ensure_array(display_field(:creator))
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
    lang = LanguageList::LanguageInfo.find(display_field(:language))

    if !lang.nil?
      lang.name
    else
      display_field(:language)
    end
  end

  def general_notes
    ensure_array(display_field(:lds01))
  end

  def source
    display_field(:source)
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

  def uniform_titles
    ensure_array(display_field(:lds31))
  end

  def record_ids
    ensure_array(display_field(:lds02))
  end

  def identifier
    id = split_row_semicolon(display_field(:identifier))
    if id
      id.collect{ | r | convert_hash_to_key_value(parse_subfields(r)) }
    else
      ""
    end
  end

  def subjects
    ensure_array(display_field(:subject))
  end


  def fulltext_links
    links = ensure_array(link_field(:linktorsrc))
    if !links && data['fulltext_available']
      links = [ "$$V#{data['links']['fulltext_url']}$$DNotre Dame Online Access" ]
    end
    links = links.collect { | l | parse_subfields(l) }

    links
  end


  def display_fields
    primo['display']
  end


  def link_fields
    primo['links']
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


    def link_field(key)
      link_fields[key.to_s]
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
      PrimoFieldSplitter.call(row)
    end


    def split_row_semicolon(row)
      if row.present?
        row.split(";").collect{ | r | r.to_s.strip }
      else
        row
      end
    end


    def parse_subfields(string)
      ret = Hash[string.scan(/\${2}([^\$])([^\$]+)/)]
      if ret.empty?
        ret = string
      end

      ret
    end


    def convert_hash_to_key_value(hash)
      if hash.is_a?(Hash)
        {hash['C'].strip => hash['V'].strip}
      else
        # This may be an error  identifier: "<b>ISSN: </b>0262-4079",
        # consider trapping this.
        hash
      end
    end
end
