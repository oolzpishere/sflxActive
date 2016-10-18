class AddCoverColumnsToGalleries < ActiveRecord::Migration[5.0]
  def up
    add_attachment :galleries, :cover
  end

  def down
    remove_attachment :galleries, :cover
  end
end
