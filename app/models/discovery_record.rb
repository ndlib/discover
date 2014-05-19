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

  def type
    data['type']
  end

  # identifier methods
  [:isbn, :issn, :eissn, :doi, :pmid, :lccn, :oclc, :record_ids].each do |field|
    define_method(field) do
      identifiers_field(field)
    end
  end

  # display methods
  [:title, :language, :general_notes, :source, :description, :contents, :edition, :publisher, :creation_date, :format, :is_part_of, :creator, :contributor, :subjects, :series, :uniform_titles].each do |field|
    define_method(field) do
      display(field)
    end
  end


  def published
    ret = []
    [:edition, :publisher, :creation_date, :format].each do | field |
      ret << send(field) if send(field)
    end

    ret
  end


  def identifiers
    ret = {}
    [:isbn, :issn, :eissn, :doi, :pmid, :lccn, :oclc].each do | field |
      ret[field] = self.send(field)
    end
    ret.delete_if {|k,v| v.blank?}

    ret
  end


  def fulltext_links
    links = ensure_array(link_field(:linktorsrc))
    if links.empty? && data['fulltext_available']
      links = [ "$$U#{data['links']['fulltext_url']}$$Dlinktosrc_ndu" ]
    end
    links = links.collect { | l | convert_url_hash(parse_subfields(l)) }

    links
  end


  def table_of_contents_links
    links = ensure_array(link_field(:linktotoc))
    links = links.collect { | l | parse_subfields(l) }

    links
  end


  def display_fields
    primo['display'] || {}
  end

  def openurl_fields
    data['openurl'] || {}
  end


  def link_fields
    primo['links'] || {}
  end


  private

    def self.make_request(id)
      API::Resource.search_catalog(id)
    end


    def identifiers_field(key)
      data['identifiers'][key.to_s]
    end

    def primo
      data['primo'] || {}
    end

    def display(key)
      data['display'][key.to_s]
    end


    def openurl(key)
      openurl_fields[key.to_s]
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
      PrimoFieldSplitter.dash(row)
    end


    def split_row_semicolon(row)
      PrimoFieldSplitter.semicolon(row)
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


    def convert_url_hash(hash)
      if hash.is_a?(Hash)
        {title: hash['E'], url: hash['U']}
      else
        # This may be an error
        # consider trapping this.
        hash
      end
    end
end


