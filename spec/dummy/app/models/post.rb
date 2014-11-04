class Post < ActiveRecord::Base
  belongs_to :dummy_object

  after_update do
    if published?
      Notifly::Notification.create receiver: self.dummy_object, target: self,
        template: :default
    end
  end

  before_destroy do
    Notifly::Notification.create receiver: self.dummy_object, template: :destroy,
      data: self.attributes
  end
end
