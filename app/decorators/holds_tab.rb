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

  def item_options(items)
    h.options_from_collection_for_select(sorted_items(items), 'id', 'institution_title')
  end

  def sorted_items(items)
    items.sort_by{|item| same_institution?(item.institution_code) ? 0 : 1 }
  end

  def pickup_options(item)
    h.options_from_collection_for_select(sorted_pickup_locations(item), 'id', 'title')
  end

  def sorted_pickup_locations(item)
    if same_institution?(item.institution_code)
      item.pickup_locations
    else
      item.pickup_locations.sort_by{|location| same_institution?(location.id) ? 0 : 1 }
    end
  end

  def base_institution_code(aleph_institution_code)
    base_code = aleph_institution_code.gsub(/_.*/,'')
    if base_code == 'HESB'
      'NDU'
    else
      base_code
    end
  end

  def same_institution?(aleph_institution_code)
    vid == base_institution_code(aleph_institution_code)
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


