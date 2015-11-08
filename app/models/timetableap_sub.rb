class TimetableapSub < ActiveRecord::Base
include ActiveModel::Validations
  belongs_to :timetableap
  belongs_to :aircompany
##  belongs_to :airport, foreign_key: "way_start", dependent: :destroy
##  belongs_to :apkey, foreign_key: "way_end", dependent: :destroy
  attr_accessible :aircompany_id, :timetableap_id, :Flight_Number
  attr_accessor :twrus, :aprus, :f_twrus, :f_aprus, :s_twrus, :s_aprus, :timeIN, :bgcolor, :fstatus, :airline, :al_plane, :plane_al, :ap2, :timeEnd, :timeStart, :apkey, :ap, :s_ap, :f_ap
  def self.search(search_al)
    if search_al
      where('aircompany_id LIKE ?', "%#{search_al}%")
    else
      all
    end
  end
end
