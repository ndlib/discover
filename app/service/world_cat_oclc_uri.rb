class WorldCatOclcUri
  attr_reader :oclc_number

  def self.call(oclc_number)
    self.new(oclc_number).uri
  end

  def initialize(oclc_number)
    @oclc_number = oclc_number
  end


  def uri
    if oclc_number.present?
      "http://www.worldcat.org/search?q=no%3A#{@oclc_number}"
    else
      ""
    end
  end

end
