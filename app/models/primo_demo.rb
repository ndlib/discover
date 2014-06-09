class PrimoDemo
  attr_reader :search_term

  def initialize(params)
    @params = params
    @search_term = params["vl(freeText0)"]
  end

  def decorator
    @decorator ||= PrimoDemoDecorator.new(self)
  end

  def body
    decorator.body
  end
end
