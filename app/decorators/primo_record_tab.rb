class PrimoRecordTab < Draper::Decorator

  delegate :params, to: :controller

  def controller
    object
  end

  def id
    params[:id]
  end

  def vid
    params[:vid] || 'NDU'
  end

  def tab
    params[:tab]
  end

  def record
    @record ||= load_record
  end

  def record_id
    record.id
  end

  def primo_configuration
    @primo_configuration = PrimoConfiguration.new(vid)
  end

  def primo_uri
    @primo_uri ||= PrimoURI.new(vid, tab)
  end

  private

    def load_record
      DiscoveryQuery.find_by_id(id, vid)
    end

end
