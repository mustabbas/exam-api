class Api::V1::UsersController < ApplicationController
    before_action :authorize_request 
    before_action :authorize_role
    
      def index
        @user = User.all
        render json: @user
      end
      def create
        @user = User.create!(user_params)
        render json: @user, status: :created
      end
  
      def edit
        @user = User.find_by(id: params[:id])
        render json: @user
      end
  
      def update
        user = User.find_by(id: params[:id])
        user.update(user_params)
        render json: user
      end
  
      def destroy
        User.find(params[:id]).destroy  
        render json: { message: 'removed' }
      end
    
      private
    
      def user_params
        params.permit(
          :name,
          :email,
          :password,
          :password_confirmation,
          :role
        )
      end
  end
  
  