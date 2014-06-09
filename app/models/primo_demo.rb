class PrimoDemo
  attr_reader :search_term

  def initialize(search_term)
    @search_term = search_term
  end

  def decorator
    @decorator ||= PrimoDemoDecorator.new(self)
  end

  def body
    decorator.body
  end
end
