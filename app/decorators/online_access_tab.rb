class OnlineAccessTab < PrimoRecordTab
  delegate :institution_code, to: :record

  def institution_links_decorators
    if @institution_links_decorators.nil?
      @institution_links_decorators = {primary: nil, other: []}
      record.links.each do |id, data|
        if id == institution_code
          @institution_links_decorators[:primary] = PrimaryInstitutionLinksDecorator.new(data)
        else
          @institution_links_decorators[:other] << InstitutionLinksDecorator.new(data)
        end
      end
    end
    @institution_links_decorators
  end

  def primary_institution_links
    institution_links_decorators[:primary]
  end

  def other_institutions_links
    institution_links_decorators[:other]
  end

  private
    def load_record
      DiscoveryQuery.fullview(id, vid)
    end
end
