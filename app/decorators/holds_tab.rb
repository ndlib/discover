class HoldsTab < PrimoRecordTab

  def url_params(merge_params = {})
    {
      id: id,
      vid: vid,
      persisted_params: holds_request.params
    }.merge(merge_params)
  end

  def patron_id
    if Rails.env.development?
      patron_id_param || 'PRIMO'
    else
      patron_id_param
    end
  end

  def patron_id_param
    if params[:patron_id].present? && params[:patron_id] != 'null'
      params[:patron_id]
    else
      nil
    end
  end


  def save_input(new_params)
    holds_request.save_params(new_params)
  end


  def persisted_params
    params[:persisted_params] || {}
  end

  def page_title
    record.title.first
  end

  def holds_data
    @holds_data ||= HoldData.new(record.holds_list)
  end

  def single_volume?
    holds_data.single_volume?
  end

  def volumes
    holds_data.volumes
  end

  def volume_option_tags
    h.options_from_collection_for_select(volumes, "id", "title")
  end

  def items(volume_id)
    holds_data.items(volume_id)
  end

  def default_cancel_date_string
    default_cancel_date.strftime('%m/%d/%Y')
  end

  def default_cancel_date
    Date.today.since(6.months)
  end

  def signin_link
    h.link_to("You must sign-in in order to place requests", primo_uri.request_tab_signin(id))
  end


  private

    def holds_request
      # create a new object passing the previous data
      @holds_request ||= HoldsRequest.new(persisted_params)
    end

    def load_record
      DiscoveryQuery.holds_list(id, patron_id)
    end


end


