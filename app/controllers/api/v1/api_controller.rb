class Api::V1::ApiController < ApplicationController
    before_action :authenticate_api_user!
    
    #protect_from_forgery with: :null_session  #use for POSTMAN TESTS only
    #skip_before_action :verify_authenticity_token


end


