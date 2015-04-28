# encoding: UTF-8
class ZonesStation < ActiveRecord::Base
cattr_reader :per_page
@@per_page = 10
  attr_accessible :code_station, :name, :region_id
end

