require 'rails_helper'

RSpec.describe 'student/test', type: :request do
    user = User.create!(name: 'default', email: 'teacher@example.com', password: '12345678', password_confirmation: '12345678',role:'Teacher')
    token = JsonWebToken.encode(user_id: user.id)
    describe 'GET /student/test' do
        before(:example) { get '/api/v1/student/test',headers: {'HTTP_AUTHORIZATION' =>  token } }
        it 'works! returns correct status code' do
          expect(response).to have_http_status(:ok)
        end
    end

    describe 'GET /student singel test' do
        before(:example) { get '/api/v1/student/test/12',headers: {'HTTP_AUTHORIZATION' =>  token } }
        it 'works! returns correct status code' do
          expect(response).to have_http_status(:ok)
        end
    end
end
