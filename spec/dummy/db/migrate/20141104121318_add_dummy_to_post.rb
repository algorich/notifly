class AddDummyToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :dummy_object, index: true
  end
end
