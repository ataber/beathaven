# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  event_date   :date
#  performer_id :integer
#  cost         :decimal(8, 2)
#  accepted     :boolean
#  event_time   :time
#  user_id      :integer
#  active       :boolean          default(TRUE)
#  transfer_id  :string(255)
#

class Booking < ActiveRecord::Base
  validates_presence_of :event_date, :cost, :performer_id, :user_id
  validate :validate_event_date, :on => :create

  belongs_to :user, inverse_of: :bookings
  belongs_to :performer, inverse_of: :bookings
  has_many :comments, inverse_of: :booking

  def past?
    event_date < Date.today
  end

  def transfer
    return unless transfer_id
    @transfer ||= Stripe::Transfer.retrieve(transfer_id)
  end

  private
  def validate_event_date
    if past?
      errors.add(:event_date, "can't be in the past")
    end
  end
end
