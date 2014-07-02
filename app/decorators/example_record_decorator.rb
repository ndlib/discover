class ExampleRecordDecorator < Draper::Decorator
  delegate :id, :description, to: :object
  def self.by_institution(institution)
    self.decorate_collection(self.records(institution))
  end

  def self.records(institution)
    institution = institution.to_s.downcase
    records = load_yaml[institution]
    records.each do |r|
      r['institution'] = institution
    end
    records
  end

  def self.load_yaml
    YAML::load_file(Rails.root.join('config', 'example_records.yml'))
  end

  def id
   get 'id'
  end

  def description
    get 'description'
  end

  def title
    get 'title'
  end

  def institution
    (get 'institution') || 'ndu'
  end

  def vid
    institution.upcase
  end

  def primo_configuration
    @primo_configuration ||= PrimoConfiguration.new(vid)
  end

  def primo_uri
    @primo_uri ||= PrimoURI.new(primo_configuration)
  end

  def record_path(format = nil)
    h.record_path(id: id, format: format)
  end

  def online_access_path(format = nil)
    h.online_access_path(id: id, format: format)
  end

  def record_link
    h.link_to('Details', record_path, target: '_blank')
  end

  def online_access_link()
    h.link_to('Online Access', online_access_path, target: '_blank')
  end

  def json_link
    h.link_to('JSON', record_path(:json), target: '_blank')
  end

  def primo_search_id
    id.gsub(/^TN_/i, '')
  end

  def primo_path
    primo_uri.basic_search(primo_search_id)
  end

  def primo_proxy_link
    h.link_to("Primo Local", primo_path, target: '_blank')
  end

  def primo_url
    "http://#{primo_host}#{primo_path}"
  end

  def primo_host
    primo_uri.host
  end

  def primo_link
    h.link_to('Primo 4', primo_url, target: '_blank')
  end

  private
    def get(key)
      object[key.to_s]
    end
end
