require 'rails'

module I18nTimezones
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'i18n-timezones' do |app|
      I18nTimezones::Railtie.instance_eval do
        pattern = pattern_from app.config.i18n.available_locales

        add("rails/locale/#{pattern}.yml")
      end
    end

    protected

    def self.add(pattern)
      files = Dir[File.join(File.dirname(__FILE__), '../..', pattern)]
      I18n.load_path.concat(files)
    end

    def self.pattern_from(args)
      array = Array(args || [])
      array.blank? ? '*' : "{#{array.join ','}}"
    end
  end
end
