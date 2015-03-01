# FilterDecrufter

FilterDecrufter is a little utility for cleaning up before_filters.

Suppose you have a Rails controller with a before_filter:

    before_filter :load_widget, :only => [:show, :frobnicate]

If you've deleted the frobnicate action, Rails won't complain.  But FilterDecrufter will!

# Usage

Add it to your Gemfile in the development group:

    # In your Gemfile
    gem 'filter_decrufter'

Run the task!

    $ bundle exec rake filter_decrufter:check 
    Api::V1::WidgetsController before_filter 'find_widget' has an :only constraint with a non-existent action name 'show'
    EmployeesController after_filter 'set_name' has an :only constraint with a non-existent action name 'frobnicate'

Tested with Rails 3.2, 4.0, and 4.2.

# Credits

* [John Moon](http://www.thinkandgrowentrepreneur.com/) - design discussions
* [Mike Foley](https://twitter.com/m1foley) - filter with multiple method bug report
* [Sandeep Kumar](https://whatpeoplethink.wordpress.com/) - Rails 4.2 support
* [Tom Copeland](http://thomasleecopeland.com) - author
