class ExampleRecordDecorator < Draper::Decorator
  delegate :id, :description, to: :object
  def self.all
    self.decorate_collection(self.records)
  end

  def self.records
    load_yaml['records']
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

  def record_path(format = nil)
    h.record_path(id: id, format: format)
  end

  def record_link
    h.link_to('Details', record_path, target: '_blank')
  end

  def json_link
    h.link_to('JSON', record_path(:json), target: '_blank')
  end

  def primo_search_id
    id.gsub(/^TN_/i, '')
  end

  def primo_path
    "/primo_library/libweb/action/search.do?vid=NDU&vl(freeText0)=#{primo_search_id}&fn=search&tab=onesearch"
  end

  def primo_url
    "http://primo-fe1.library.nd.edu:1701#{primo_path}"
  end

  def primo_link
    h.link_to('Primo 4', primo_url, target: '_blank')
  end

  private
    def get(key)
      object[key.to_s]
    end
end
