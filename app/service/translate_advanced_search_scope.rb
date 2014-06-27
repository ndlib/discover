class TranslateAdvancedSearchScope
  TRANSLATIONS = { 'series' => 'lsr30', 'uniform_title' => 'lsr31', 'related_title' => 'title', 'subject' => 'sub' }

  attr_reader :scope

  def initialize(scope)
    @scope = scope
  end

  def translate
    translated = scope.downcase

    TRANSLATIONS[translated] || translated
  end

  def self.call(scope)
    self.new(scope).translate
  end
end
