class AddSoundcloudUrlToPerformers < ActiveRecord::Migration
  def change
    add_column :performers, :soundcloud_url, :string
  end
end
