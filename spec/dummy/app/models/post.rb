class Post < ActiveRecord::Base
  belongs_to :dummy_object

  # after_create do
  #   Notifly::Notify.create receiver: self, template: :default if published?
  # end

  def published?
    self.published
  end
end


