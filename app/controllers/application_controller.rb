class ApplicationController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    
    #protect_from_forgery with: :null_session
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation,:name,:nickname])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :session, :format])
        devise_parameter_sanitizer.permit(:sign_out, keys: [:session])      
        devise_parameter_sanitizer.permit(:account_update, keys:[:email,:password, :password_confirmation,:name,:nickname])
    end
end
