Notifly
---

This project intend to offers a full notification system. Right now our
notification is composed by:

  - Receiver (**required**): the object that will receive the notification
  - Sender: who sent the notification
  - Target: object that you will refer
  - Data: hash where you can store more info about the notification
  - Template (**required**): template html that the notification will use
  - Read: attribute that shows if the receiver read the notification


Install
---

First we need to add our gem to `Gemfile` and run `bundle`

```ruby
  # Gemfile

  gem 'notifly', github: 'algorich/notifly', branch: 'dev'
```

After that we need to configure our gem

```shell
  $ rails generate notifly:install [NAMESPACE]
```

You can choose to change the namespace for our routes, but the default is `notifly`

We need storage the notifications and to do it do not forget to run the migrations

```shell
  $ rake db:migrate
```

Now you need our assets, add it to your `application.js`

```javascript
//= require notifly
```

You need to have a `current_user` in `ApplicationController`, if you use
[Devise](https://github.com/plataformatec/devise) it is already there.

Usage
---

You will need at least an user object to be the receiver. We have to ways to create
notifications.

```ruby
  receiver_object.notifly!
```

Remember that you can pass all Notifications attributes (`target`, `sender`, `data`
and `template`) to this method.

We use a default template but if you want to change it or create new ones run the
code below or create them in `app/views/notifly/templates`

```shell
  $ rails generate notifly:views
```

Now if you want to use your layout, just generate them adding the option `--layout`
to the code above and change them as you want.
