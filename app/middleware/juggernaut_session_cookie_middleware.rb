require 'rack/utils'

class JuggernautSessionCookieMiddleware
  def initialize(app, session_key = '_session_id')
    @app = app
    @session_key = session_key
  end

  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^Ruby\//
      params = ::Rack::Utils.parse_query(env['QUERY_STRING'])
      env['HTTP_COOKIE'] = [ @session_key, params['session_id'] ].join('=').freeze unless params['session_id'].nil?
    end
    @app.call(env)
  end
end
