# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_railsmud_session',
  :secret      => '9d848679fdc090d3207ba9ca3b3a5e5cfaef1cec401e4f666f6904fdd5550b43e5ba3a086a6dfcddd712b19582bbdbf5d4168fc4aa3097c7244297f3fbd1f732'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

ActionController::Dispatcher.middleware.insert_before(
  ActionController::Base.session_store,
  JuggernautSessionCookieMiddleware,
  ActionController::Base.session_options[:key])
