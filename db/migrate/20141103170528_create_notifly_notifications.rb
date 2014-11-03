class CreateNotiflyNotifications < ActiveRecord::Migration
  def change
    create_table :notifly_notifications do |t|
      t.string :template
      t.boolean :read
      t.references :target, index: true, polymorphic: true
      t.references :sender, index: true, polymorphic: true
      t.references :receiver, index: true, polymorphic: true

      t.timestamps
    end
  end
end
