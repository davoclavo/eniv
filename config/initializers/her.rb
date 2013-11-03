require 'vine_token_authentication'
require 'response_logger'

class VineParser < Faraday::Response::Middleware
  def on_complete(env)
    json = MultiJson.load(env[:body], symbolize_keys: true)
    env[:body] = {
      data: json[:data][:records],
      error: json[:code],
      success: json[:success],
      code: json[:code]
    }
  end
end

# Her::API.setup url: "https://api.vineapp.com/", proxy: 'http://localhost:8080', ssl: {verify: false} do |c|
Her::API.setup url: "https://api.vineapp.com/" do |c|
  # Request
  c.use VineTokenAuthentication
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON
  # c.use ResponseBodyLogger, $logger
  # c.use Faraday::Response::Logger, $logger
  c.use VineParser
  c.use Faraday::Response::Logger,          Logger.new('faraday.log')
  # c.use Faraday::Response::RaiseError       # raise exceptions on 40x, 50x responses
  # Adapter
  c.use Faraday::Adapter::NetHttp
end
