class HierarchicalField
  attr_reader :values, :scope

  def initialize(scope, values)
    @values = values
    @scope = scope
  end

  def text_values
    values['fulltext']
  end

  def hierarchical_values
    values['hierarchical']
  end

  def search_values
    if @search_values.nil?
      @search_values = hierarchical_values.collect{|split| hierarchical_to_search_values(split)}
    end
    @search_values
  end

  private
    def hierarchical_to_search_values(array)
      array.map.with_index{|value, index| [value, hierarchical_to_search_value(array, index)] }
    end

    def hierarchical_to_search_value(array, index)
      array[0, index + 1].join(' ')
    end
end
