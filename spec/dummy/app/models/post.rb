class Post < ActiveRecord::Base
  notifly before: :create, template: :default, if: :published?
  notifly before: :destroy, template: :default, if: :published?

  # after_create do
  #   Notifly::Notify.create receiver: self, template: :default, if: :published?
  # end

  def published?
    self.published
  end
end


