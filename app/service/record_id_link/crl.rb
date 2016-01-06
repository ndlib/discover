class RecordIdLink::CRL < Draper::Decorator
  def self.render(record_id)
    self.new(record_id).render
  end

  def self.renders?(record_id)
    (record_id =~ /crlcat/).present?
  end

  def render
    h.link_to(direct_link_title, direct_url, target: '_blank')
  end

  private

  def crl_number
    @crl_number ||= object.match(/^crlcat[.](.*).+$/)[1]
  end

  def direct_url
    "http://catalog.crl.edu/record=#{crl_number}"
  end

  def direct_link_title
    "Center For Research Libraries: #{crl_number}"
  end
end