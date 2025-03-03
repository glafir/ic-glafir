Rails.application.configure do
  # Compress JavaScripts and CSS.
#  config.assets.js_compressor = :uglifier
  config.assets.js_compressor = Uglifier.new(harmony: true)
  config.assets.css_compressor = :sass
  config.assets.compile = true
  config.assets.digest = false

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
#  config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 60.minutes }
#  config.cache_store = :redis_cache_store, { expires_in: 60.minutes }
  config.cache_store = :null_store

  # Do not eager load code on boot.
  config.eager_load = false
#  config.action_dispatch.rack_cache = {
#    metastore:   'redis://localhost:6379/1/metastore',
#    entitystore: 'redis://localhost:6379/1/entitystore'
#  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.assets.quiet = true
  config.serve_static_assets = false
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
