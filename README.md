# treehouse-rails
treehouse-rails is a Rails engine with middleware for Treehouse authentication

## Installation

Add this line to your application's Gemfile:

```shell
$ gem 'treehouse-rails', git: 'git@github.com:printreleaf/treehouse-rails'
```

And then execute:

```shell
$ bundle
```

## Configuration

Create `config/initializers/treehouse.rb`:

```ruby
Treehouse.configure do |config|
  config.url    = "http://yourtreehouse.com"
  config.key    = "your-treehouse-key"
  config.cookie = "_treehouse_session"
  config.site   = "http://mysite.com"
end
```

## Usage

Treehouse adds its session to the Rack environment hash so Rails and other Rack applications can interact with it:

```ruby
session = request.env[:treehouse] #=> #<Treehouse::Session:0x007f8610411a48>
session.logged_in? #=> true
login = session.current_login #=> #<Treehouse::Login:0x007f860efc3208>
login.id #=> 123
login.email #=> "bob@example.com"
```

## Dummy mode

When Treehouse is in dummy mode, `#current_login` will always return a dummy instance of `Treehouse::Login`:

```ruby
Treehouse.configure do |config|
  config.dummy = true
end

request.env[:treehouse].current_login #=> #<Treehouse::Login:0x007f860efc3208 @id=123, @email="bob@example.com">
```

It can be helpful to enable dummy mode in development:

```ruby
Treehouse.configure do |config|
  config.dummy = Rails.env.development?
end
```

## Testing

```shell
$ rspec spec
```

## Contributing

1. Fork it ( https://github.com/printreleaf/treehouse-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

MIT

