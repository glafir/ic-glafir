class ZonesStation < ActiveRecord::Base
include ActiveModel::Validations
cattr_reader :per_page
@@per_page = 10
  attr_accessible :code_station, :name, :region_id
end

