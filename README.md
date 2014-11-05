Notifly
---

This project rocks and uses MIT-LICENSE.

Usage
---

You will need at least an user object, after that just add this code where you want

```ruby
  Notifly::Notification receiver: user
```

This code will inject the notification's view and to show it you must have our assets,
so add it to your application.js

```javascript
//= require notifly
```