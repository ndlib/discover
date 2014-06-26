class PrimoConfiguration
  attr_reader :vid

  def initialize(vid)
    @vid = vid.to_s.upcase
  end

  def tabs
    vid_configuration['tabs']
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
      YAML.load_file(Rails.root.join('config', 'primo.yml'))
    end
end
