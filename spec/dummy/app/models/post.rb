class Post < ActiveRecord::Base
  belongs_to :dummy_object

  notifly default_values: { receiver: :dummy_object, target: :self }

  notifly before: :destroy, template: :destroy, data: :attributes

  notifly after: :publish!, template: :publish
  notifly before: :change_title, data: -> { { title_before_create: title } },
    unless: -> { title == 'TitleFoo' }
  notifly after:  :change_title, data: :attributes, template: :change_title,
    if: -> { self.title == 'NewTitle' }

  def publish!
    update(published: true)
  end

  def change_title(title='NewTitle')
    self.title = title
    self.save
  end
end