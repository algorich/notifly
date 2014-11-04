class Post < ActiveRecord::Base
  belongs_to :dummy_object

  after_update do
    Notifly::Notification.create receiver: self.dummy_object, template: :default if published?
  end
end


