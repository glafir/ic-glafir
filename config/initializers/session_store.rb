# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_ic_app_session'
Rails.application.config.session_store :active_record_store, key: '_ic_app_session'
#Rails.application.config.session_store :redis_cache_store,
#  servers: ["redis://localhost:6379/0/session"],
#  expire_after: 7200.minutes,
#  key: "_#{Rails.application.class.parent_name.downcase}_session",
#  threadsafe: true,
#  signed: true,
#  secure: true
