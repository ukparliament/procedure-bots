class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  include LibraryDesign::Crumbs
  
  $SITE_TITLE = 'Procedure Bots'
  
  $DATE_DISPLAY_FORMAT = '%-d %B %Y'
  
  $DATETIME_DISPLAY_FORMAT = '%-d %B %Y @ %H:%M'
end
