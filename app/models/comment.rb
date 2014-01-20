# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  booking_id :integer
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Comment < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :booking
  belongs_to :user
end
