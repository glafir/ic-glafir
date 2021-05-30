class AirportTerminalGate < ApplicationRecord
include ActiveModel::Validations
paginates_per 500
belongs_to :airport_terminal
end
