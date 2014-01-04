# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  event_date   :datetime
#  performer_id :integer
#  cost         :decimal(8, 2)
#

class Booking < ActiveRecord::Base
  validates_presence_of :event_date, :cost
  belongs_to :performer
end
