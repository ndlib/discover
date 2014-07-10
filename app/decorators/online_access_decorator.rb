class OnlineAccessDecorator < Draper::Decorator

  def self.find(id, vid)
    record = DiscoveryQuery.fullview(id, vid)
    self.new(record)
  end

  delegate :institution_code, to: :object

  def insitution_links
    if @insitution_links.nil?
      @insitution_links = {}

      ordered_institution_codes.each do |code|
        tmp_links = object.links(code)
        if tmp_links.present?
          @insitution_links[code] = InstitutionLinksDecorator.new(tmp_links)
        end
      end
    end
    @insitution_links
  end


  def nd_links
    InstitutionLinksDecorator.new(object.ndu_links)
  end


  def smc_links
    InstitutionLinksDecorator.new( object.smc_links )
  end


  def hcc_links
    InstitutionLinksDecorator.new( object.hcc_links )
  end


  def bci_links
    InstitutionLinksDecorator.new( object.bci_links )
  end


  private


    def ordered_institution_codes
      codes = ["ndu", "smc", "hcc", "bci"]
      codes.delete(institution_code)
      # Make the current insitution first in the links
      codes.unshift(institution_code)

      codes
    end

end
