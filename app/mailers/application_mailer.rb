# frozen_string_literal: true

# Base mailer class for the application.
#
# This class provides default settings for all mailers, including
# the default sender email and layout.
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
