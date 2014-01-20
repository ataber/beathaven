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
#  accepted     :boolean
#

class Booking < ActiveRecord::Base
  validates_presence_of :event_date, :cost
  validate :validate_event_date, :on => :create

  belongs_to :performer
  has_many :comments

  private
  def validate_event_date
    if event_date.present? && event_date < Date.today
      errors.add(:event_date, "can't be in the past")
    end
  end
end
