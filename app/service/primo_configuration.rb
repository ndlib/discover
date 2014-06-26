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

  private
    def vid_configuration
      vids[vid] || {}
    end

    def vids
      configuration['vids'] || {}
    end

    def configuration
      @configuration ||= self.class.load_configuration
    end

    def self.load_configuration
      configuration = YAML.load_file(Rails.root.join('config', 'primo.yml'))
      configuration[Rails.env] || configuration['default']
    end
end
