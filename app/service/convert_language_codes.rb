class ConvertLanguageCodes

  def self.call(codes)
    if codes.present?
      codes.collect do |code|
        converter = new(code)
        converter.translate
      end
    else
      codes
    end
  end

  attr_reader :code

  def initialize(code)
    @code = code
  end

  def translate
    translate_language_list || translate_iso_639 || code
  end

  def translate_language_list
    translated = LanguageList::LanguageInfo.find(code)
    if translated.present?
      translated.name
    else
      nil
    end
  end

  def translate_iso_639
    translated = ISO_639.find(code)
    if translated.present?
      translated.english_name
    else
      nil
    end
  end
end
