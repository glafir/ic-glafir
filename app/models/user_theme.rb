class UserTheme < ActiveRecord::Base
include ActiveModel::Validations
  has_many :user
end
