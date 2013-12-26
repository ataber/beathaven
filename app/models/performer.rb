class Performer < ActiveRecord::Base
  belongs_to :user
  scope :genre, lambda { |genre| where("genre = ?", genre) }
  scope :name_like, lambda { |text| where("name ILIKE ? OR genre ILIKE ?", "%" + text + "%", "%" + text + "%") }
end
