class RecordLinks < Draper::Decorator
  def record
    object
  end

  def links
    record.links
  end

  def institution_links
    get(:institutions)
  end

  def institution_code
    record.institution_code
  end

  def institution_links_decorators
    if @institution_links_decorators.nil?
      @institution_links_decorators = {primary: nil, other: []}
      institution_links.each do |id, data|
        if id.upcase == institution_code.upcase
          @institution_links_decorators[:primary] = PrimaryInstitutionLinksDecorator.new(data)
        else
          @institution_links_decorators[:other] << InstitutionLinksDecorator.new(data)
        end
      end
    end
    @institution_links_decorators
  end

  def primary_institution_links
    institution_links_decorators[:primary]
  end

  def other_institutions_links
    institution_links_decorators[:other]
  end

  def all_additional_links
    @all_additional_links ||= [].tap do |array|
      [:table_of_contents, :finding_aids, :reviews, :add_links].each do |key|
        array.concat(additional_links(key))
      end
    end
  end

  def additional_links(key)
    additional_links_decorators(key).collect { |decorator| decorator.link }
  end

  def additional_links_decorators(key)
    get(key).collect { |link| LinkDecorator.new(link) }
  end

  private
    def get(key)
      links[key.to_s]
    end
end
