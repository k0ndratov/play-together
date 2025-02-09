# frozen_string_literal: true

# Base controller for the application.
#
# This controller serves as the foundation for all other controllers,
# applying global configurations and security policies.
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
