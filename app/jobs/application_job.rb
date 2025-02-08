# frozen_string_literal: true

# Base class for background jobs.
#
# This class inherits from `ActiveJob::Base` and provides default behavior
# for all jobs in the application.
class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
