class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :turbo_native_app?

  def turbo_native_app?
    request.headers["User-Agent"]&.include?("Turbo Native")
  end
end
