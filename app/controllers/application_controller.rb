class ApplicationController < ActionController::Base
  protect_from_forgery
  http_basic_authenticate_with :name => "kairo77", :password => "tl9008"
end
