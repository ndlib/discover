class OnlineAccessTab < PrimoRecordTab
  delegate :institution_code, to: :record

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


  def nd_links
    InstitutionLinksDecorator.new(record.ndu_links)
  end


  def smc_links
    InstitutionLinksDecorator.new( record.smc_links )
  end


  def hcc_links
    InstitutionLinksDecorator.new( record.hcc_links )
  end


  def bci_links
    InstitutionLinksDecorator.new( record.bci_links )
  end


  private
    def load_record
      DiscoveryQuery.fullview(id, vid)
    end

    def get_domain_name(url)
      return if url.nil?

      uri = URI.parse(url)
      if uri.present?
        uri.host.gsub('www.', '')
      else
        nil
      end
    end
end
