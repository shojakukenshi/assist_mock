class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Basic authentication for production environment
  http_basic_authenticate_with name: Rails.configuration.x.basic_auth.username, password: Rails.configuration.x.basic_auth.password if Rails.env.production?
end
