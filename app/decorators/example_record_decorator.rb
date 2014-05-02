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

  def record_link
    h.link_to('Details', h.record_path(id: id))
  end

  private
    def get(key)
      object[key.to_s]
    end
end
