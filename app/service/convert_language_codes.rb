class ConvertLanguageCodes

  def self.call(codes)
    self.new.convert(codes)
  end


  def convert(codes)
    if codes.present?
      codes.collect do |l|
        translated = LanguageList::LanguageInfo.find(l)
        if translated.present?
          translated.name
        else
          l
        end
      end
    else
      nil
    end

  end

end
