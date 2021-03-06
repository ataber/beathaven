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
  validates_presence_of :content, :user_id, :booking_id
  belongs_to :booking, inverse_of: :comments
  belongs_to :user
end
