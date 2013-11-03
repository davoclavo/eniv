class VineParser < Faraday::Response::Middleware
  def call(env)
    @app.call(env).on_complete do
      json = MultiJson.load(env[:body], symbolize_keys: true)
      env[:body] = {
        attributes: json[:data][:records][0],
        error: json[:error],
        success: json[:success],
        code: json[:code]
      }.to_json
    end
  end
end
