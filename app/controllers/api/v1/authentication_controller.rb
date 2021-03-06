class Api::V1::AuthenticationController < ApplicationController
 
    def authenticate
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), role:@user.role
                         }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end
  
    private
  
    def auth_params
      params.permit(:email, :password)
    end
  end