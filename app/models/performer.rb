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
#  recipient_id   :string(255)
#

class Performer < ActiveRecord::Base
  validates_presence_of :name, :price, :user_id

  belongs_to :user, inverse_of: :performers
  has_many :bookings, -> { where active: true }, inverse_of: :performer
  has_many :unscoped_bookings, class_name: "Booking"
  has_many :reviews, inverse_of: :performer

  scope :genre_like, lambda { |genre| where("genre ILIKE ?", "%" + genre + "%") }
  scope :name_like, lambda { |text| where("name ILIKE ? OR genre ILIKE ?", "%" + text + "%", "%" + text + "%") }

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
