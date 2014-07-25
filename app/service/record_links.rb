class RecordLinks < Draper::Decorator
  def record
    object
  end

  def links
    record.links
  end

  def institution_links
    links['institutions']
  end

  def institution_code
    record.institution_code
  end

  def institution_links_decorators
    if @institution_links_decorators.nil?
      @institution_links_decorators = {primary: nil, other: []}
      institution_links.each do |id, data|
        if id == institution_code
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
end
