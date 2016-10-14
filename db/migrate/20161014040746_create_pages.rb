class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.integer   :parent_id
      t.string    :path
      t.string    :slug
      t.string    :custom_slug
      t.boolean   :show_in_menu,        :default => true
      t.string    :link_url
      t.string    :menu_match
      t.boolean   :deletable,           :default => true
      t.boolean   :draft,               :default => false
      t.boolean   :skip_to_first_child, :default => false
      t.integer   :lft
      t.integer   :rgt
      t.integer   :position
      t.integer   :depth
      t.string    :view_template
      t.string    :layout_template

      t.string    :title
      t.string    :menu_title
      t.text      :body
      t.text      :side_body
      t.boolean   :show_in_footer
      t.string    :locale

      t.timestamps
    end

    add_index :pages, :depth
    add_index :pages, :id
    add_index :pages, :lft
    add_index :pages, :parent_id
    add_index :pages, :rgt
    add_index :pages, :position

  end
end
