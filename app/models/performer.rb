# == Schema Information
#
# Table name: performers
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  user_id        :integer
#  genre          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  soundcloud_url :string(255)
#  description    :text
#  price          :decimal(8, 2)
#

class Performer < ActiveRecord::Base
  validates_presence_of :name, :price

  belongs_to :user, inverse_of: :performers
  has_many :bookings, -> { where active: true }, inverse_of: :performer
  has_many :unscoped_bookings, class_name: "Booking"
  has_many :reviews, inverse_of: :performer

  scope :genre_like, lambda { |genre| where("genre ILIKE ?", "%" + genre + "%") }
  scope :name_like, lambda { |text| where("name ILIKE ? OR genre ILIKE ?", "%" + text + "%", "%" + text + "%") }
end
