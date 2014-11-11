Notifly
---

This project rocks and uses MIT-LICENSE.

Install
---

First we need to add our gem to `Gemfile` and run `bundle`

```ruby
  # Gemfile

  gem 'notifly', git: 'git://github.com:algorich/notifly.git'
```

After that we need to configure our gem

```shell
  $ rails generate notifly:install [NAMESPACE]
```

You can choose to change the namespace for our routes, but the default is `notifly`

Now you need our assets, add it to your `application.js`

```javascript
//= require notifly
```

Usage
---

You will need at least an user object, after that just add this code where you want

```ruby
  Notifly::Notification receiver: user
```

If you want to change the default template ou create new ones

```shell
  $ rails generate notifly:views
```

Now if you want to use your layout, just generate them adding the option `--layout`
to the code above and change them as you want.