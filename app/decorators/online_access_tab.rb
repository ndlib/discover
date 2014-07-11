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
    @other_institutions ||= institutions.reject{|institution| institution.id != institution_code}
  end

  def insitution_links
    if @insitution_links.nil?
      @insitution_links = {}
      institution_codes = ["ndu", "smc", "hcc", "bci"]
      institution_codes.delete(institution_code)
      # Make the current insitution first in the links
      institution_codes.unshift(institution_code)
      institution_codes.each do |code|
        tmp_links = record.links(code)
        if tmp_links.present?
          @insitution_links[code] = InstitutionLinksDecorator.new(tmp_links)
        end
      end
    end
    @insitution_links
  end

  private
    def load_record
      DiscoveryQuery.fullview(id, vid)
    end
end
