class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.text :videoId
      t.integer :playlistId

      t.timestamps
    end
  end
end
