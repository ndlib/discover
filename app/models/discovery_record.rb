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

  def institution_code
    data['institution_code']
  end

  # identifier methods
  [:isbn, :issn, :eissn, :doi, :pmid, :lccn, :oclc, :record_ids].each do |field|
    define_method(field) do
      identifiers_field(field)
    end
  end

  # display methods
  [:title, :vernacular_title, :language, :biographical_note, :general_notes, :source, :description, :contents, :edition, :publisher, :creation_date, :format, :is_part_of, :creator, :contributor, :subjects, :series, :uniform_titles, :earlier_title, :later_title, :supplement, :supplement_to, :issued_with, :variant_title].each do |field|
    define_method(field) do
      display(field)
    end
  end


  def published
    ret = []
    [:edition, :publisher, :creation_date, :format].each do | field |
      ret += send(field) if send(field)
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

  def holdings
    data['holdings'] || {}
  end

  def display_fields
    primo('display') || {}
  end

  def links
    data['online_access']
  end

  private


    def identifiers_field(key)
      data['identifiers'][key.to_s]
    end

    def primo(key)
      data['primo'][key.to_s]
    end

    def display(key)
      data['display'][key.to_s]
    end

end


