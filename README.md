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
  - If and Unless: used to create notifications conditionally


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

We have two ways to create notifications, with both you will need at least an user
object to be the receiver. You can define notifications creation with `notifly`

```ruby
class TicketOrder < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :buyer
  belongs_to :owner

  notifly default_values: { receiver: :owner }

  notifly before: :destroy, template: :destroy, sender: :buyer, data: :attributes
  notifly after: :send_gift!, template: :ticket_gift, sender: :buyer, target: :ticket,
    if: -> { completed? }

  def send_gift!
    # code here
  end
end
```

with this way you can use the `default_values` to DRY your notiflies. If you want
you can create notifications with

```ruby
class TicketOrder < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :buyer
  belongs_to :owner

  before_destroy do
    owner.notifly! template: :destroy, sender: :buyer, data: :attributes
  end

  def send_gift!
    # code here

    if completed?
      owner.notifly! template: :ticket_gift, sender: :buyer, target: :ticket
    end
  end
end
```

We use a default template but if you want to change it or create new ones run the
code below or create them in `app/views/notifly/templates`

```shell
  $ rails generate notifly:views
```

Now if you want to use your layout, just generate them adding the option `--layout`
to the code above and change them as you want.
