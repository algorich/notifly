class AddKindToNotiflyNotification < ActiveRecord::Migration
  def change
    add_column :notifly_notifications, :kind, :string, default: :notification
  end
end
