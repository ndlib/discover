class PrimoSearchUri
  include ActiveModel::Validations

  BASE_URI = 'http://primo-fe1.library.nd.edu:1701/primo_library/libweb/action/search.do'

  attr_accessor :type, :search

  validates :type, inclusion: { in: %w(title creator subject uniform_title related_title series) }
  validates :type, :search, presence: true


  def self.call(search, type)
    self.new(search, type).uri
  end


  def initialize(search, type)
    @search = search
    @type   = type

    validate!
  end


  def uri
    "#{BASE_URI}?#{url_hash.to_query}"
  end


  private

    def url_hash
      {
        "vl(freeText0)" => search,
        "vl(16833817UI0)"=> translate_type,
        "vl(1UIStartWith0)"=>"exact",
        "fn"=>"search",
        "tab"=>"onesearch",
        "mode"=>"Advanced",
        "vid"=>"NDU"
      }
    end


    def translate_type
      TranslateType.call(type)
    end


    def validate!
      if invalid?
        raise errors.to_s
      end
    end


    class TranslateType
      TYPE_TRANSLATIONS = { 'series' => 'lsr03', 'uniform_title' => 'lsr04', 'related_title' => 'title', 'subject' => 'sub' }

      def self.call(type)
        self.new.translate(type)
      end

      def translate(type)
        type = type.downcase

        if TYPE_TRANSLATIONS[type]
          type = TYPE_TRANSLATIONS[type]
        end

        type
      end
    end
end
