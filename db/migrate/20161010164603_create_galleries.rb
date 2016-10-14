class CreateGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :galleries do |t|
      t.string :title
      t.text :body
      t.text :side_body
      t.integer :position
      # t.integer :images

      t.timestamps
    end

    add_index :galleries, :id
    # add_index :galleries, :images
  end
end
