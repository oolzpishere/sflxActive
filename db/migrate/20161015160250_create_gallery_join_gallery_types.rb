class CreateGalleryJoinGalleryTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :gallery_join_gallery_types do |t|
      t.integer :gallery_id
      t.integer :gallery_type_id

      t.timestamps
    end

    add_index :gallery_join_gallery_types, :id
  end
end
