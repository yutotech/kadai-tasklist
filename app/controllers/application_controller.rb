class ApplicationController < ActionController::Base
    
    include SessionsHelper, UsersHelper
    
    private
    
    def require_user_logged_in
        unless logged_in?
            redirect_to login_url
        end
    end
end
