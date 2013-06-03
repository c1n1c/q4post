class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :slug, :null => false
      t.string :title
      t.text :content

      t.references :user, :foreign_key => {:dependent => :delete}

      t.timestamps
    end

    add_index :posts, :user_id
  end
end
