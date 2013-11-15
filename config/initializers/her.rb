# Require custom middleware
Dir[File.expand_path('../../../lib/faraday/*.rb', __FILE__)].each do |file|
  dirname = File.dirname(file)
  file_basename = File.basename(file, File.extname(file))
  require "#{dirname}/#{file_basename}"
end

Her::API.setup url: Settings.api_host do |c|
  # Request
  # c.use Faraday::Request::UrlEncoded
  c.use VineHeaderInjector

  # Response
  c.use Her::Middleware::DefaultParseJSON
  c.use VineParser
  c.use GzipExtractor
  # c.use Faraday::Response::RaiseError         # raise exceptions on 40x, 50x responses

  c.use ResponseBodyLogger,                   $logger
  c.use Faraday::Response::Logger,            $logger

  # Adapter
  c.use Faraday::Adapter::NetHttp
end
