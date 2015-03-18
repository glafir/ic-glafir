# encoding: UTF-8
class RwStation < ActiveRecord::Base
belongs_to :rw_typestation
  attr_accessible :rw_zone, :name_eng, :name_rus, :rw_typestation_id, :rw_route_id
end

