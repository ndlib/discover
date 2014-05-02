class ExampleRecordsDecorator < Draper::Decorator
  def self.all
    self.decorate_collection(self.records)
  end

  def self.records
    load_yaml['records']
  end

  def self.load_yaml
    YAML::load_file(Rails.root.join('config', 'example_records.yml'))
  end
end
