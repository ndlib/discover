class ExampleRecordCollection < Draper::Decorator
  def institution
    object.to_s.downcase
  end

  def records
    ExampleRecordDecorator.decorate_collection(yaml_records)
  end

  def yaml_records
    institution_yaml.tap do |records|
      records.each do |r|
        r['institution'] = institution
      end
    end
  end

  def institution_yaml
    load_yaml[institution]
  end

  def load_yaml
    YAML::load_file(Rails.root.join('config', 'example_records.yml'))
  end
end
