class OnlineAccessTab < PrimoRecordTab
  delegate :institution_code, to: :record

  def institution_decorators
    if @institution_decorators.nil?
      @institution_decorators = {primary: nil, other: []}
      record.links.each do |id, data|
        if id == institution_code
          @institution_decorators[:primary] = PrimaryInstitutionLinksDecorator.new(data)
        else
          @institution_decorators[:other] << InstitutionLinksDecorator.new(data)
        end
      end
    end
    @institution_decorators
  end

  def primary_institution
    institution_decorators[:primary]
  end

  def other_institutions
    institution_decorators[:other]
  end

  private
    def load_record
      DiscoveryQuery.fullview(id, vid)
    end
end
