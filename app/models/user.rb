# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  stripe_customer_id     :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :email, :presence => true, :uniqueness => true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :performers, inverse_of: :user
  has_many :bookings, -> { where active: true }, inverse_of: :user
  has_many :unscoped_bookings, class_name: "Booking"
  has_many :comments, inverse_of: :user
  has_many :reviews, inverse_of: :user

  def payment_history
    return unless stripe_customer_id
    @payment_history ||= Stripe::Charge.all(customer: stripe_customer_id)
  end
end
