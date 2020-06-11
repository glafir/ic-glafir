class AirlineCodeshare < ActiveRecord::Base
include ActiveModel::Validations
  belongs_to :aircompany
  belongs_to :codeshare, class_name: "Aircompany", foreign_key: "codeshare_id"
  paginates_per 25
  validates :code_share_start, presence: true, length: { is: 10 }
  validates :code_share_finish, presence: true, length: { is: 10 }
  validates :aircompany_id, presence: true, numericality: { only_integer: true }
  validates :codeshare_id, presence: true, numericality: { only_integer: true },
     uniqueness: { scope: :aircompany_id, message: "This Airline with the Coshere-company is exist!" }
end
