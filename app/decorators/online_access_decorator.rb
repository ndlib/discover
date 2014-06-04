require 'uri/http'

class OnlineAccessDecorator < Draper::Decorator

  def self.find(id)
    record = DiscoveryQuery.find_by_id(id)
    self.new(record)
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
