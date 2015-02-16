# FilterDecrufter

FilterDecrufter is a little utility for cleaning up before_filters.

Suppose you have a Rails controller with a before_filter:

    before_filter :load_widget, :only => [:show, :frobnicate]

If you've deleted the frobnicate action, Rails won't complain.  But FilterDecrufter will!

# Usage

Add it to your Gemfile in the development group:

    # In your Gemfile
    gem 'filter_decrufter'

Tell your Rakefile to load up the FilterDecrufter tasks (well, task):

    # In your Rakefile
    require 'filter_decrufter/tasks'

And run the task!

    $ bundle exec rake filter_decrufter:check 
    Api::V1::WidgetsController before_filter find_widget has an :only constraint with a non-existent action name show
    EmployeesController before_filter set_name has an :only constraint with a non-existent action name frobnicate

Tested with Rails 3.2.

# Credits

* Tom Copeland - author
* John Moon - design discussions