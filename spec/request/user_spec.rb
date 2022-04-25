require 'rails_helper'

RSpec.describe 'users', type: :request do
    user = User.create!(name: 'default', email: 'teacher@example.com', password: '12345678', password_confirmation: '12345678',role:'Teacher')
    token = JsonWebToken.encode(user_id: user.id)
    describe 'POST /signup' do
        before(:example) do
            post '/api/v1/signup', headers: {'HTTP_AUTHORIZATION' =>  token }, params: {name: 'teacher', email: 'teacher@example.com', password: '12345678',password_confirmation: '12345678',role:'Teacher' }
        end
        it 'works! returns correct status code' do
            expect(response).to have_http_status(:created)
        end
    end

    describe 'GET /users' do
        before(:example) { get '/api/v1/users',headers: {'HTTP_AUTHORIZATION' =>  token } }
        it 'works! returns correct status code' do
          expect(response).to have_http_status(:ok)
        end
    end

    describe 'GET /singel user' do
        before(:example) { get '/api/v1/user/12/edit',headers: {'HTTP_AUTHORIZATION' =>  token } }
        it 'works! returns correct status code' do
          expect(response).to have_http_status(:ok)
        end
    end

    describe 'put /user/update' do
        before(:example) do
            put "/api/v1/user/#{user.id}", headers: {'HTTP_AUTHORIZATION' =>  token }, params: {name: 'teacher', email: 'teacher@example.com', password: '12345678',password_confirmation: '12345678',role:'Teacher' }
        end
        it 'works! returns correct status code' do
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'destroy /user' do
        before(:example) do
            delete "/api/v1/user/#{user.id}/destroy", headers: {'HTTP_AUTHORIZATION' =>  token }
        end
        it 'works! returns correct status code' do
            expect(response).to have_http_status(:ok)
        end
    end
end
