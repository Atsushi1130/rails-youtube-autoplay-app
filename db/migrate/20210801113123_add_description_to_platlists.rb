class AddDescriptionToPlatlists < ActiveRecord::Migration[6.1]
  def change
    add_column :playlists, :description, :text
  end
end
