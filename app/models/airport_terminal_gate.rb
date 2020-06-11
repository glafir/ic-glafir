class AirportTerminalGate < ApplicationRecord
include ActiveModel::Validations
paginates_per 100
belongs_to :airport_terminal
end
