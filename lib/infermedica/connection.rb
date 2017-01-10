module Infermedica

  # HTTP error raised when we don't get the expected result from an API call
  class HttpError < StandardError; end

  # = Connection
  # handles the http communication
  # No assumption is made about content or return values
  # The caller is responsible for converting to/from json

  class Connection 

    # Default host. Can be overwritten with *endpoint: '/some/endpoint'
    # When creating the Connection

    ENDPOINT = 'https://api.infermedica.com'

    def initialize(args)
      raise ArgumentError, 
      'Infermedica::Connection::initialize argument needs to be a Hash' unless
        args.is_a?(Hash)
      raise ArgumentError, 'api_id is required' unless args.key?(:api_id)
      raise ArgumentError, 'api_key is required' unless args.key?(:api_key)
      args[:endpoint] = ENDPOINT unless args.key?(:endpoint)

      # Probably need more argument validation here...
      args.each do |k, v|
        instance_variable_set(:"@#{k}", v)
      end

      uri = URI.parse(@endpoint)
      @http = Net::HTTP.new(uri.host, uri.port)
      @http.use_ssl = true

      @headers = {
        'App-Id':  @api_id,
        'App-Key': @api_key,
      }
      @headers['Dev-Mode'] = args[:dev_mode] if args.key?(:dev_mode)
    end

    # TODO: Might have to deal with args

    # Send a get request to the given path
    def get(path)
      # TODO: do more hardening on the path
      request = Net::HTTP::Get.new('/v2' + path, @headers)
      send_request(request)
    end

    # Send a post request to the given path
    # json is the data to be passed to the post command
    # params are additional header entries

    def post(path, json, params = {})
      request = Net::HTTP::Post.new('/v2' + path, @headers)
      request.add_field('Content-Type', 'application/json')
      request.body = json
      params.each do |k, v|
        request[k] = v
      end
      send_request(request)
    end

    private

    # Check the response code, raise an exception in case of error

    def validate_response(response) # :nodoc:
      code = response.code.to_i
      raise HttpError, "#{code} #{response.msg}" if code < 200 || code > 299
    end

    # Send the request, validate it
    # Parse the JSON response into a data structure.

    def send_request(request) # :nodoc:
      response = @http.request(request)
      validate_response(response)
      JSON.parse(response.body)
    end
  end
end
