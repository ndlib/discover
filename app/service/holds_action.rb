class HoldsAction

  def self.initialize(controller)
    new(controller.params[:id], controller.params[:vid])
  end


  def initialize(id, vid)
    @id = id
    @vid = vid
  end


  def record
    @record ||= HoldsDecorator.new(DiscoveryQuery.fullview(@id, @vid))
  end


  def can_be_requested?
    true
  end


  def needs_to_select_volume?
    true
  end


  def needs_to_select_item?
    true
  end


  def template
    'show'
  end

end


