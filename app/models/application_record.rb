# frozen_string_literal: true

# Abstract base class for all application models.
#
# This class inherits from `ActiveRecord::Base` and serves as the base
# for all models in the application. It is marked as an abstract class,
# meaning it should not be instantiated directly.
#
# All application models should inherit from `ApplicationRecord`
# instead of `ActiveRecord::Base` to maintain consistency.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
