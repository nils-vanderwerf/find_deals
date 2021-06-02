# FindDeals

Welcome to your this awesome find deals gem, whicgh scrapes https://www.scoopon.com.au/ and finds the best deals in a specific area, from a specific category.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'find_deals'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install find_deals

## Usage

1. Type in the number of the Australian city you're interested in viewing.
2. Type in the category you're interested in viewing (some combinations are unavailable - unfortunately there are no deals for a selection).
3. It will come up with a list of deals with their title, location, price and discount.
4. Type in a number you want to see more about
5. It will give a short description of the selected deal.
6. Specify Y or N (Yes or No) about whether you want to save the current deal.
7. If yes, it will need a username to associate the deal with the user.
8. If you click Y for Yes in the next step, it will print your saved deals.
9. You are now presented with options - 
    - you can type it 'more' to see more deals (it is case insensitive)
    - you can type it 'city' to see your saved deals by city
    - you can type it 'categories' to your saved deals by category
    -  you can type it 'delete' to delete one of your saved deals
10. It will then loop around to the appropriate function.


## Development

After checking out the repo, run `bin/setup` to install dependencies, which includes the database migrations.
To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nils-vanderwerf/find_deals. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nils_vanderwerf/find_deals/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FindDeals project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/find_deals/blob/master/CODE_OF_CONDUCT.md).
