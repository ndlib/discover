class PrimoConfiguration
  attr_reader :vid

  def initialize(vid)
    @vid = vid.to_s.upcase
  end

  def host
    configuration['host']
  end

  def default_tab
    tabs.first
  end

  def tabs
    vid_configuration['tabs'] || []
  end

  def advanced_search_scope_name
    advanced_search_configuration['scope_name']
  end

  private

    def configuration
      @configuration ||= self.class.load_configuration
    end

    def vids
      configuration['vids'] || {}
    end

    def vid_configuration
      vids[vid] || {}
    end

    def advanced_search_configuration
      vid_configuration['advanced_search'] || {}
    end

    def self.load_configuration
      configuration = YAML.load_file(Rails.root.join('config', 'primo.yml'))
      configuration[Rails.env] || configuration['default']
    end
end
