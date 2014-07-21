class ExampleRecordCollection < Draper::Decorator
  def institution
    object.to_s.downcase
  end

  def title
    h.t("institutions.#{institution}")
  end

  def primo_configuration
    @primo_configuration ||= PrimoConfiguration.new(institution)
  end

  def tabs
    primo_configuration.tabs
  end

  def tab_links
    tabs.collect do |tab|
      uri = PrimoURI.new(primo_configuration, tab)
      h.link_to(tab, uri.basic_search('test'), target: '_blank')
    end
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

  def institutions
    load_yaml.keys
  end

  def institution_links
    institutions.collect do |key|
      institution_title = h.t("institutions.#{key}")
      if key == institution
        institution_title
      else
        h.link_to(institution_title, h.examples_path(key))
      end
    end
  end

  def load_yaml
    @load_yaml ||= YAML::load_file(Rails.root.join('config', 'example_records.yml'))
  end
end
