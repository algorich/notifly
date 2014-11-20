# Notifly

This project intend to offer a full notification system, back and front-end.
In actual version, notifications are composed by:

  - Receiver (**required**): the object that will receive the notification
  - Sender: who sent the notification
  - Target: object that you will be the subject between the sender and receiver
  - Data: hash where you can store more info about the notification
  - Template (**required**): html template used by notification
  - Read: flag that records if the receiver read the notification
  - Seen: flag that records if the receiver seen the notification
  - If and Unless: used to create notifications conditionally


# Install

First we need to add the gem to `Gemfile`

```ruby
  gem 'notifly', github: 'algorich/notifly', branch: 'dev'
```

Run the bundle command to install it. After that, you need to run the initializer

```shell
  $ rails generate notifly:install
```

You can choose to change the namespace for Notifly routes, but the default is `notifly`.
It will creates `config/initializers/notifly.rb` too. Also, in this file you can
see/change the default configs

Notifly **need** to storage the notifications and to do it you need to run the migrations

```shell
  $ rake db:migrate
```

# Usage

## Back-end

We have two ways to create notifications, with both you will need at least an user
object to be the receiver. You can define notification's creation with `notifly`

```ruby
class TicketOrder < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :buyer
  belongs_to :owner

  notifly default_values: { receiver: :owner }

  notifly before: :destroy, template: :destroy, sender: :buyer, data: :attributes
  notifly after: :send_gift!, template: :ticket_gift, sender: :buyer,
    target: :ticket, if: -> { completed? }
  notifly after: :accept_gift, sender: :owner, receiver: :buyer, target: :ticket

  def send_gift!
    # code here
  end

  def accept_gift
    # code here
  end
end
```

Note that with this way you can use the `default_values`, it is specific to DRY your
notiflies, the values there will be in all notiflies, but if you want to overwrite
some default value in a specific notifly, just declare it again like the
`:accept_gift` notifly above.

If you want you can create notifications with the "hard" way

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

  def accept_gift
    # code here

    buyer.notifly! sender: :owner, target: :ticket
  end
end
```

To access the notifications we have tree ways

  - `object.notiflies` (**TODO**)
  - Querying `Notifly::Notifications`
  - Using our front-end helpers

## Front-end

First, you need to have a `current_user` in `ApplicationController`, if you use
[Devise](https://github.com/plataformatec/devise) it is already there.

After that you need our assets, add them to your `application.js`

```javascript
//= require notifly
```

```css
/*
*= require notifly
*/
```

Now finally you can see the notifications view adding code bellow to your view

```html
<%= notiflies %>
```

This will inject our views and it will be like that

![image](http://upl.io/i/4i26o3.png)

As you can see, notifications are rendered with their templates, we use a simple
default template but if you want to change it or create new ones run the code below
or create them in `app/views/notifly/templates`

```shell
  $ rails generate notifly:views
```

Now if you want to customize the layout, just generate it adding the option `--layout`
to the code above and change it as you want. But if you already have a layout and just
want add our features to it, take a look at [Adapting your layout](#adapting).

### <a name='adapting'></a> Adapting your layout

All partials that we insert in your layout are in the gem or if you generated them,
they will be in `app/views/notifly/layouts/`

Above are the elements that will loading the Notifly in your layout

  - **Counter**: this element will show how many notifications are not seen. It
    should have the id `#notifly-counter`, and the html rendered in will be
    the `_counter.html.erb`
  - **Notifications icon**: this element is the trigger to load the notifications
    and you should have an icon to show when the user "have notifications" and
    "do not have notifications" this element should have the id `#notifly-icon`. The
    html icon is defined in our view helper `notifly_icon` you can overwrite it,
    just remember that this method should have the argument `have_notifications=false`
    and is this method that tell us which icon will be in the view.
  - **Notifications**: they will be inserted in `#notifly-notifications-container`,
    this element will contain all notifications (`_notification.html.erb`) rendered
    by `_index.html.erb`
  - **Next page link**: this link will append the next notifications page to the
    `#notifly-notifications-container`, this is rendered by `_footer.html.erb` and
    will be injected in `#notifly-notifications-footer`
  - **Loading**: html element that will be showing while the notifications request
    isn't completed. It should be in `#notifly-notifications-container` and should
    have the class `loading`
  - **Mark as read**: this link will mark all notifications in the page as read,
    it will be rendered in `#notifly-header-actions`
  - **Toggle read**: this link will be rendered by `_actions.html.erb' in
    `_notification.html.erb`



