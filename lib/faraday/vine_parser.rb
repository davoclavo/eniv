class VineParser < Faraday::Response::Middleware
  def call(env)
    @app.call(env).on_complete do
      json = MultiJson.load(env[:body], symbolize_keys: true)
      if json[:success]

        attributes = get_attributes(json[:data])
        
        env[:body] = {
          attributes: attributes,
          error: json[:error],
          success: json[:success],
          code: json[:code]
        }.to_json
      else
        raise VineError.new(json)
      end
    end
  end

  def get_attributes(data)
    if data[:records]
      if data[:records].count > 1
        attributes = data[:records]
      elsif data[:records].count == 1
        attributes = data[:records][0]
      end
    elsif data.class == Hash
      attributes = data
    end
  end
end
