class OnlineAccessTab < PrimoRecordTab
  delegate :institution_code, to: :record

  def institutions
    if @institutions.nil?
      @institutions = record.links.collect{|id, institution| InstitutionLinksDecorator.new(institution)}
    end
    @institutions
  end

  def primary_institution
    @primary_institution ||= institutions.detect{|institution| institution.id == institution_code}
  end

  def other_institutions
    @other_institutions ||= institutions.reject{|institution| institution.id == institution_code}
  end

  private
    def load_record
      DiscoveryQuery.fullview(id, vid)
    end
end
