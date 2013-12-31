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
#

require 'spec_helper'

describe Performer do
  pending "add some examples to (or delete) #{__FILE__}"
end
