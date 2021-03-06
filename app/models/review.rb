# == Schema Information
#
# Table name: reviews
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  performer_id :integer
#  content      :text
#  hidden       :boolean          default(FALSE), not null
#

class Review < ActiveRecord::Base
  belongs_to :user, inverse_of: :review
  belongs_to :performer, inverse_of: :reviews
  validates_presence_of :content, :performer_id, :user_id
end
