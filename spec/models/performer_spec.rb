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
#

require 'spec_helper'

describe Performer do
  pending "add some examples to (or delete) #{__FILE__}"
end
