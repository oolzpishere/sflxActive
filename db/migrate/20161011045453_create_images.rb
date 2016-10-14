class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :gallery_id
      t.integer :position
      t.attachment :image

      t.timestamps
    end

    add_index :images, :id
    add_index :images, :gallery_id
    
  end
end
