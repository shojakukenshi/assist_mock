class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Basic authentication for production environment
  http_basic_authenticate_with name: Rails.application.config.basic_auth_username,
                                password: Rails.application.config.basic_auth_password,
                                if: -> { Rails.env.production? }
end
