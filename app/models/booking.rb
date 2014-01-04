class Booking < ActiveRecord::Base
  validates_presence_of :event_date, :cost
  belongs_to :performer
end