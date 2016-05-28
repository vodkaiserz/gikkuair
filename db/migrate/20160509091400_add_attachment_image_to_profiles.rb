class AddAttachmentImageToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :profilepic
      t.attachment :coverphoto
    end
  end

  def self.down
    remove_attachment :profiles, :profilepic, :coverphoto
end
end