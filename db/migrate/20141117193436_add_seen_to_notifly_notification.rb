class AddSeenToNotiflyNotification < ActiveRecord::Migration
  def change
    add_column :notifly_notifications, :seen, :boolean, default: false
  end
end
