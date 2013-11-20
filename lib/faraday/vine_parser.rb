class VineParser < Faraday::Response::Middleware
  def call(env)
    @app.call(env).on_complete do
      json = MultiJson.load(env[:body], symbolize_keys: true)
      if json[:success]
        # metadata : count, etc
        env[:body] = normalize_attributes(json[:data]).to_json
      else
        raise VineError.new(json)
      end
    end
  end

  def normalize_attributes(data)
    # Data may be a hash containing records, or just the record itself, we make it always an array to normalize it
    records = data.try(:[], :records) || data
    if records.kind_of?(Array)
      records
    else
      [records]
    end
  end
end
