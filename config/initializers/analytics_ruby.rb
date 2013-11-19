Analytics = AnalyticsRuby # Alias for convenience
Analytics.init({
    secret: Secrets.segmentio.secret,
    on_error: Proc.new { |status, msg| print msg }  # Optional error handler
})

