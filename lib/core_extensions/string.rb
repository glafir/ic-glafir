module CoreExtensions
  module String
    def to_time_zone_name
      strip!
      return self if ActiveSupport::TimeZone::MAPPING.key?(self)

      ActiveSupport::TimeZone::MAPPING.invert[self]
    end

    def valid_time_zone_name?
      to_time_zone_name.present?
    end
  end
end
