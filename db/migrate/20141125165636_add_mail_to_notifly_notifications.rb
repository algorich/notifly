class AddMailToNotiflyNotifications < ActiveRecord::Migration
  def change
    add_column :notifly_notifications, :mail, :string
  end
end
