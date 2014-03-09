class AddAvatarToPerformers < ActiveRecord::Migration
  def up
    add_attachment :performers, :avatar
  end

  def down
    remove_attachment :performers, :avatar
  end
end
