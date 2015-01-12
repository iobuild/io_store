# Why io_store
io_store is an engine for Rails that aims to be the best lightweight e-commerce system.
The end goal is to have an engine that can be dropped into an application.


# Installation

Using Rails 4

```ruby
gem 'io_store', :git => "git://github.com/iobuild/io_store.git"
```

And then one of `kaminari` or `will_paginate`
```ruby
gem 'kaminari', '0.15.1'
# OR
gem 'will_paginate', '3.0.5'
```
And then need awesome_nested_set to create Category model
```ruby
gem 'awesome_nested_set'
```

## Run the installer

**Ensure that you first of all have a `User` model and some sort of authentication system set up**. We would recommend going with [Devise](http://github.com/plataformatec/devise), but it's up to
you. All io_store needs is a model to link topics and comments to.

Run the installer and answer any questions that pop up. There's sensible defaults there if you don't want to answer them.

```shell
rails g io_store:install
```

## Set up helper methods in your user model

io_store uses a `iostore_name` (which defaults as `to_s`) method being available on your `User` model so that it can display the user's name in topics. Define it in your model like this:

```ruby
def iostore_name
  name
end
```



Change the default layout setting in config/initializers/io_store.rb
```ruby
IoStore.layout = 'default'
```


## Require basic io_store assets

Add this line to your `application.js` file to load required JavaScript files:

```js
//= require io_store
```

Add this line to your `application.css` to apply required styling:

```css
*= require 'io_store/main'
```


And you're done! Yaaay!


## Features

Here's a comprehensive list of the features currently in io_store:

* Products
  * carts management
  * address management
  * support alipay


If there's a feature you think would be great to add to io_store, let us know on [the Issues
page](https://github.com/iobuild/io_store/issues)



io_store's default layout includes this tag.

## View Customisation

If you want to customise io_store, you can copy over the views using the (Devise-inspired) `io_store:views` generator:

    rails g io_store:views

You will then be able to edit the io_store views inside the `app/views/io_store` of your application. These views will take precedence over those in the engine.

## Extending Classes

All of io_store business logic (models, controllers, helpers, etc) can easily be extended / overridden to meet your exact requirements using standard Ruby idioms.

Standard practice for including such changes in your application or extension is to create a directory app/decorators. place file within the relevant app/decorators/models or app/decorators/controllers directory with the original class name with _decorator appended.

### Adding a custom method to the Topic model:

```ruby
# app/decorators/models/io_store/cart_decorator.rb

IoStore::Cart.class_eval do
  def some_method
    ...
  end
end
```

### Adding a custom method to the CartsController:

```ruby
# app/decorators/controllers/io_store/carts_controller_decorator.rb

IoStore::CartsController.class_eval do
  def some_action
    ...
  end
end
```

The exact same format can be used to redefine an existing method.

## Currently support the following languages:

* Chinese (Simplified, zh-CN)

Patches for new translations are very much welcome!


## OMG BUG! / OMG FEATURE REQUEST!

File an issue and we'll get around to it when we can.

## Developing on io_store

io_store is implemented as a Rails engine and its specs are run in the context of a dummy Rails app. The process for getting the specs to run is similar to setting up a regular rails app:

    bundle exec rake io_store:dummy_app

Once this setup has been done, io_store's specs can be run by executing this command:

    bundle exec rspec spec

If all the tests are passing (they usually are), then you're good to go! Develop a new feature for io_store and be lavished with praise!

## Contributors

* Arly Xiao ([@arlyxiao](https://github.com/arlyxiao))
* [List of all contributors](https://github.com/iobuild/io_store/contributors)

## Places using io_store

* [Example Name](http://example.com)

If you want yours added here, just ask!
