class PrimoFieldSplitter

  def self.call(field)
    self.new(field).split
  end


  def initialize(field)
    @field = field
  end


  def split
    if @field.present?
      @field.split("--").collect{ | r | r.to_s.strip }
    else
      @field
    end
  end
end
