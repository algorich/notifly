# Notifly [![Build Status](https://travis-ci.org/algorich/notifly.svg?branch=master)](https://travis-ci.org/algorich/notifly) [![Dependency Status](https://gemnasium.com/algorich/notifly.svg)](https://gemnasium.com/algorich/notifly)

This project is still under development and it intend to offer a full notification
system, back and front-end. Questions and suggestions are welcome and you can
use the [issues list](https://github.com/algorich/notifly/issues) on Github to
provide that feedback.

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
  gem 'notifly'
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
  $ rake notifly:install:migrations
  $ rake db:migrate
```

# Usage

## Back-end

We have two ways to create notifications:

#### 1. Using `#notifly` method in your classes (as callback)

If you want to create notifications after (or before) **any** method call.

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
Value explanation about each parameter:

| Parameter           | Value         |
| ------------------- | ------------- |
| `before` or `after` | The method which will create notification before or after its call |
| `receiver`          | The method which returns the notification receiver object          |
| `sender`            | The method which returns the notification sender object            |
| `template`          | The symbol or string that indicates which partial will be rendered at views. The partial must be inside `app/views/notifly/templates/`. Default is `:default`. |
| `target`            | The method which returns the notification target object. It's a third actor of the notification. Example: In "Max sent you a ticket" notification, Max is the sender, you are the receiver and the **ticket is the target**. |
| `data`              | A method which returns a hash with usefull values to be persisted, like ticket price or whatever you want to persist. |

Note that you can use the `default_values` parameter, it is specific to DRY your
notiflies and set the values to all notiflies. If you need to overwrite some
default value, just declare it again like the `:accept_gift` notifly above.


#### Using `#notifly!` method on your receiver object

If you need to create notifications without callbacks, even in the
controller scope.

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

The receiver will be always the object which you call `#notifly!`

You can access the notifications using the following methods:

  - `receiver_object.notiflies`
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

Notifications are rendered with their templates. It uses a simple default
template but if you want to change it or create new ones run the code below
or create them in `app/views/notifly/templates/_your_template.html.erb`

```shell
  $ rails generate notifly:views --notification
```

| Option           | Description |
| ---------------- | ----------- |
| `--notification` | generates notifications templates files |
| `--layout`       | generates layout files |
| `--mail`         | generates mail templates files |

If you already have a layout and just want add our features to it, take a look
at [Adapting your layout](#adapting).

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

# Contributing

Consider to use [zenhub](https://www.zenhub.io/), with it will know what issues
and features are in "progress" or "to do". Also, I encourage you to use
[git-flow](http://github.com/nvie/gitflow) and [EditorConfig](http://editorconfig.org).

Fork the repository.  Then, run:

```shell
  git clone git@github.com:<username>/notifly.git
  cd notifly
  git branch master origin/master
  git flow init -d
  git flow feature start <your-feature>
```

Then, do work and commit your changes.

```shell
  git flow feature publish <your feature>
```

When done, open a pull request to your feature branch.
