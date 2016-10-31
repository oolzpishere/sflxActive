class AddTypesToGalleries < ActiveRecord::Migration[5.0]
  def change
    add_column :galleries, :types, :string
  end
end
