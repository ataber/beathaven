# == Schema Information
#
# Table name: recipients
#
#  id        :integer          not null, primary key
#  stripe_id :string(255)      not null
#

class Recipient < ActiveRecord::Base
  has_many :performers, inverse_of: :recipient

  def stripe_record
    Stripe::Recipient.retrieve(id: api_id)
  end
end
