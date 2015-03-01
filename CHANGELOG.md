## 0.0.5 (2015-02-28)

* [FIXED] If a filter/action contains both an 'except' and an 'only' constraint and both referred to an unused action, FilterDecrufter will no longer display both as being 'only' constraints.
* [FIXED] No longer is an exception raised if a filter is defined with multiple methods, e.g., `before_action :foo, :bar, :only => :buz`

## 0.0.4 (2015-02-27)

* [FIXED] Check for before|after|around_action for Rails 4.2

## 0.0.3 (2015-02-18)

* [FIXED] No longer reports all violations as being for before_filters
* [NEW] Rake tasks are required automatically now

## 0.0.2 (2015-02-17)

* [NEW] Works fine with Ruby 1.9.3

## 0.0.1 (2015-02-16)

* [NEW] Initial release