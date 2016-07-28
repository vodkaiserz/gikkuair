class AddProfileIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :profile_id, :integer
  end
end
