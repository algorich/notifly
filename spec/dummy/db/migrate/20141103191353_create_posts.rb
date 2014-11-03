class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :author
      t.string :title
      t.text :content
      t.boolean :published, default: false
    end
  end
end
