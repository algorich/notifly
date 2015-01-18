puts 'Seeding...'
DummyObject.delete_all
Post.delete_all
Notifly::Notification.delete_all

dummy = DummyObject.create! name: 'dummy', email: 'dummy@exemple.com'
smart = DummyObject.create! name: 'smart', email: 'smart@exemple.com'

12.times do |n|
  post = Post.create! author: "author #{n}", published: false, dummy_object: dummy

  Notifly::Notification.create! template: :default, read: false, seen: false, target: post,
    sender: smart, receiver: dummy, mail: :never
  sleep(0.5)
end