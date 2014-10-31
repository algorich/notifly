class CreateDummyObjects < ActiveRecord::Migration
  def change
    create_table :dummy_objects do |t|
      t.string :name

      t.timestamps
    end
  end
end
