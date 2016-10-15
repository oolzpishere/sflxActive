class CreateGalleryTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :gallery_types do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end

    add_index :gallery_types, :id
  end
end
