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
  validates_presence_of :name, :soundcloud_url

  belongs_to :user, inverse_of: :performers
  belongs_to :recipient
  has_many :bookings, -> { where active: true }, inverse_of: :performer
  has_many :unscoped_bookings, class_name: "Booking"
  has_many :reviews, inverse_of: :performer

  scope :with_recipient, -> { where("recipient_id IS NOT NULL") }
  scope :with_user, -> { where("user_id IS NOT NULL") }

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large:  '500x500>'
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.search(text)
    exp = "%#{text}%"
    where("name ILIKE ? OR genre ILIKE ? OR location ILIKE ?", exp, exp, exp)
  end

  def soundcloud_avatar_url
    soundcloud_profile.avatar_url
  end

  def ready_to_book?
    billing_exists? && price.present? && user.present?
  end

  def billing_exists?
    recipient_id.present?
  end

  def soundcloud_profile
    @profile ||= SoundcloudProfile.new(soundcloud_url)
  end

  def expires_on
    # TODO: figure out a better way to have a date select in billing page
    2.months.from_now
  end
end
