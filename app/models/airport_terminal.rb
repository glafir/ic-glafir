class AirportTerminal < ApplicationRecord
include ActiveModel::Validations
paginates_per 300
has_many :airport_terminal_gates
belongs_to :airport
end
