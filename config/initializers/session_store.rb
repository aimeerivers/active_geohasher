# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_active_geohasher_session',
  :secret      => 'fabee4fa06db7e6e1db89eb799cffe411d73467c0bb65bb18b2d7e7268d16100fa337ccd0a629fa0412bdd2c58433d68e83277c53ce75a1cea52285e9e1a0ae9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
