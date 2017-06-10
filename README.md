# PublicPrimaryKey

It's often advantageous to use integer primary keys,
but it may be disadvantageous to expose the size of your database to open internet.
This gem makes it easy to continue using an integer primary key internally in your code,
while displaying a more obscure public primary key that does not give clues to the size of
your database to your users.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'public_primary_key'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install public_primary_key

## Usage

For now, this gem only supports ActiveRecord.

### Step 1: Choose a model that you want to use `public_primary_key` with

- Add a string column to your model that will store your public_primary_key
(for this example I'm assume you named the column `hash_id`, but you can name it whatever you like)
- (Recommended) Add an index in the database
- (Recommended) Check for uniqueness at the database level
- Add the following to your model

```ruby
class Post < ApplicatonRecord
  public_primary_key :hash_id
end
```

- (Optionally) you can set which generator is used by `SecureRandom` (default is `urlsafe_base64`)
- (Optionally) you can set the length of the primary key string (default is 10)
- Result: users would go to `/posts/TukHuqisTm4l6A` instead of `/posts/1`.
- If you're migrating an existing table to use this gem, be sure to backfill the new column.

```ruby
class Post < ApplicationRecord
  public_primary_key :hash_id, generator: :hex, length: 12
end
```

### Step 2: Update your controllers

Because public_primary_key overwrites the default `to_param` method, you will need to update your controllers.
For the example above, go to the `posts_controller.rb` and change the `set_post` private method to

```ruby
def set_post
  @post = Post.find_by_hash_id(params[:id])
end
```

You'll also want to remove `hash_id` from the list of trusted parameters in the `post_params` method.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/public_primary_key. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

