class AddDataToNotification < ActiveRecord::Migration
  def change
    add_column :notifly_notifications, :data, :text
  end
end
