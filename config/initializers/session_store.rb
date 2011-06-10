# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_socialum_session',
  :secret      => 'e3f2f5bcaba432b6c91f4059e0d8f06262174bbfae6d2c670be3576112dd64d089819a6d5aa03c4cecaa7b9cf716ce5109c5688a76eb015aac59037112c41c91'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
