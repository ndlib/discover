class PrimoRecordTab < Draper::Decorator
  delegate :params, to: :controller

  def controller
    object
  end

  def id
    param(:id)
  end

  def vid
    param(:vid) || 'NDU'
  end

  def tab
    if @tab.nil?
      if param(:tab) == 'null'
        nil
      else
        @tab = param(:tab)
      end
    end
    @tab
  end

  def record
    @record ||= load_record
  end

  def record_id
    record.id
  end

  def primo_configuration
    @primo_configuration ||= PrimoConfiguration.new(vid)
  end

  def primo_uri
    @primo_uri ||= PrimoURI.new(primo_configuration, tab)
  end

  private

    def load_record
      DiscoveryQuery.find_by_id(id, vid)
    end

    def param(key)
      params[key]
    end

end
