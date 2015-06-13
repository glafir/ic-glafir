class RwRoute < ActiveRecord::Base
include ActiveModel::Validations
  attr_accessible :end_route, :start_route
end

