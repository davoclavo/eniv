class VineHeaderInjector < Faraday::Middleware
  def call(env)
    env[:request_headers]['vine-session-id'] = RequestStore.store[:my_api_token] || Secrets.vine_session_id

    env[:request_headers]['Content-Type']    = 'application/json; charset=utf-8'
    env[:request_headers]['User-Agent']      = 'iphone/1.3.1 (iPhone; iOS 6.1.4; Scale/2.00)'
    env[:request_headers]['Accept-Language'] = 'en;q=1, fr;q=0.9, de;q=0.8, ja;q=0.7, nl;q=0.6, it;q=0.5'
    env[:request_headers]['X-Vine-Client']   = 'ios/1.3.1'
    env[:request_headers]['Accept-Encoding'] = 'gzip, deflate'
    env[:request_headers]['Connection']      = 'keep-alive'
    @app.call(env)
  end
end
