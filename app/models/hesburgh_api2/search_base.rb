#file = File.open("path-to-file.tar.gz", "rb")
#contents = file.read

module HesburghAPI2
  class SearchBase
    BASE_PATH = "/"

    def self.base_path
      const_get(:BASE_PATH)
    end

    def self.get_json(path, params = {})
      JSON.parse(get(path, params, :json))
    end

    def self.get(path, params = {}, format = nil)
      require 'open-uri'
      open(api_url(path, params, format)).read
    end

    def self.put(path, params = {})
        connection = rest_connection
        connection.path = path + auth_token_string
        connection.verb = 'put'
        connection.payload = params
        connection.transact
    end

    def self.rest_connection
        ExternalRest.new(base_url: base_uri, path: nil, connection_opts: { response_format: 'json' })
    end

    def self.connection
        require 'faraday'
        Faraday.new() do |faraday|
            faraday.request  :url_encoded             # form-encode POST params
            faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
    end

    def self.api_url(path, params = {}, format = nil)
      if format.present?
        extension = ".#{format}"
      end
      params[:auth_token] = yml['token']
      File.join(yml['url'], base_path, "#{path}#{extension}?#{convert_params_to_string(params)}")
    end

    def self.base_uri
      File.join(yml['url'], base_path)
    end

    def self.auth_token_string
        "?auth_token=" + yml['token']
    end


    protected

      def self.convert_params_to_string(params)
        params.to_query
      end

      def self.yml
        @yml ||= YAML.load_file(File.join(Rails.root, "config", 'hesburgh_api.yml'))
        @yml[Rails.env]
      end

  end
end
