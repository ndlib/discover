class OnlineAccessTab < PrimoRecordTab
  delegate :institution_code, to: :record

  def record_links
    @record_links ||= RecordLinks.new(record)
  end

  def primary_institution_links
    record_links.primary_institution_links
  end

  def other_institutions_links
    record_links.other_institutions_links
  end

  private
    def load_record
      DiscoveryQuery.fullview(id, vid)
    end
end
