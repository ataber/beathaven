class Performer < ActiveRecord::Base
  belongs_to :user
  scope :genre, lambda { |genre| where("genre = ?", genre) }
end
