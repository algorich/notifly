class Post < ActiveRecord::Base
  belongs_to :dummy_object

  after_update do
    if published?
      self.dummy_object.notifly! target: self
    end
  end

  before_destroy do
    self.dummy_object.notifly! template: :destroy, data: self.attributes
  end
end
