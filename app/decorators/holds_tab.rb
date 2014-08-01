class HoldsTab < PrimoRecordTab

  def url_params(merge_params = {})
    {
      id: id,
      vid: vid,
      persisted_params: holds_request.params
    }.merge(merge_params)
  end

  def patron_id
    'MLC200046090'
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

  def volumes
    holds_data.volumes
  end

  def volume_option_tags
    h.options_from_collection_for_select(volumes, "id", "title")
  end

  def items(volume_id)
    holds_data.items(volume_id)
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


