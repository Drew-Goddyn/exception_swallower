# Exception Swallower

Occasionally, you may have a situation where you want all methods in a class to not raise a particular exception. Verbosely this can be accomplished with:

```Ruby
class Foo
  class PopGoesTheWeasel < StandardError; end

  def self.class_method_a
  rescue PopGoesTheWeasel
  end

  def self.class_method_b
  rescue PopGoesTheWeasel
  end

  def instance_method_a
  rescue PopGoesTheWeasel
  end

  def instance_method_b
  rescue PopGoesTheWeasel
  end
end
```

This differs from something like active_support `#rescue_from` as it is intended to do nothing with the exceptions and return nil (swallowed).

## Installation

Add this line to your application's Gemfile:

`gem 'exception_swallower'`

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install exception_swallower`

## Usage

include the module in any classes you want to be able to swallow exceptions:

```Ruby
class Foo
  include exception_swallower
  ...
end
```

Once included, you can define an array of exceptions you'd like swallowed for all methods (both class and instance) within the class:

```Ruby
class Foo
  class ExceptionA < StandardError; end
  class ExceptionB < StandardError; end

  include exception_swallower
  swallow_exceptions ExceptionA, ExceptionB
end
```

When any of these exceptions are raised within a method, they will automatically be rescued and swallowed:

```Ruby
class Foo
  class ExceptionA < StandardError; end
  class ExceptionB < StandardError; end

  include exception_swallower
  swallow_exceptions ExceptionA, ExceptionB

  def self.my_method
    puts "it's working!"
    raise ExceptionA
  end
end

Foo.my_method #=> "it's working!"
```
