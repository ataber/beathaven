# == Schema Information
#
# Table name: performers
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  user_id             :integer
#  genre               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  soundcloud_url      :string(255)
#  description         :text
#  price               :decimal(8, 2)
#  recipient_id        :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  location            :string(255)
#  active              :boolean          default(TRUE)
#

class Performer < ActiveRecord::Base
  validates_presence_of :name, :price, :user_id

  belongs_to :user, inverse_of: :performers
  has_many :bookings, -> { where active: true }, inverse_of: :performer
  has_many :unscoped_bookings, class_name: "Booking"
  has_many :reviews, inverse_of: :performer

  scope :with_recipient, where("recipient_id IS NOT NULL")
  scope :genre_like, lambda { |genre| where("genre ILIKE ?", "%" + genre + "%") }
  scope :search, lambda { |text| where("name ILIKE ? OR genre ILIKE ? OR location ILIKE ?", "%" + text + "%", "%" + text + "%", "%" + text + "%")}

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large:  '500x500>'
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def billing_exists?
    recipient_id.present?
  end

  def expires_on
    # TODO: figure out a better way to have a date select in billing page
    2.months.from_now
  end
end
