class HierarchicalField
  attr_reader :field

  def initialize(field)
    @field = field
  end

  def text_values
    field['fulltext']
  end

  def hierarchical_values
    field['hierarchical']
  end

  def search_values
    if @search_values.nil?
      @search_values = hierarchical_values.collect{|split| hierarchical_to_search_values(split)}
    end
    @search_values
  end

  private
    def hierarchical_to_search_values(array)
      array.map.with_index{|value, index| array[0, index + 1].join(' ') }
    end
end
