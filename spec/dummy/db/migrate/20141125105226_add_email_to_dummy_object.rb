class AddEmailToDummyObject < ActiveRecord::Migration
  def change
    add_column :dummy_objects, :email, :string
  end
end
