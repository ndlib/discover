module HesburghAPI2
  class Discovery < SearchBase

    class NotFound < Exception
    end

    BASE_PATH = "/2.0/discovery/"

    def self.record(q, vid = 'NDU')
      result = get_json("detail", {q: q, vid: vid})

      if result['records'].blank?
        raise NotFound.new()
      else
        result['records'].first
      end
    end

    def self.fullview(q, vid = 'NDU')
      result = get_json("fullview", {q: q, vid: vid})

      if result['records'].blank?
        raise NotFound.new()
      else
        result['records'].first
      end
    end

    def self.holds_list(record_id, patron_id)
      result = get_json("holds/list/#{patron_id}", {discovery_id: record_id})

      if result.blank?
        raise NotFound.new()
      else
        result
      end
    end

    def self.place_hold(params)
        put("holds/request", params)
    end


    def self.holdings(q, vid = 'NDU')
      result = get_json("holdings", {q: q, vid: vid})

      if result.blank?
        raise NotFound.new()
      else
        result['records'].first
      end
    end
  end
end
