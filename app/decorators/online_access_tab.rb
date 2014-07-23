class OnlineAccessTab < PrimoRecordTab
  delegate :institution_code, to: :record

  def institution_links
    @institution_links ||= InstitutionLinks.new(record)
  end

  def primary_institution_links
    institution_links.primary_institution_links
  end

  def other_institutions_links
    institution_links.other_institutions_links
  end

  private
    def load_record
      DiscoveryQuery.fullview(id, vid)
    end
end
