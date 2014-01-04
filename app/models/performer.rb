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
  belongs_to :user
  has_many :bookings
  scope :genre, lambda { |genre| where("genre ILIKE ?", genre) }
  scope :name_like, lambda { |text| where("name ILIKE ? OR genre ILIKE ?", "%" + text + "%", "%" + text + "%") }
end
