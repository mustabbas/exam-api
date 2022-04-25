require 'rails_helper'

RSpec.describe 'authentication', type: :request do
     User.create!(name: 'default', email: 'teacher@example.com', password: '12345678', password_confirmation: '12345678',role:'Teacher')
    describe 'POST /login' do
        before(:example) do
            post '/api/v1/auth/login', params: { email: 'teacher@example.com', password: '12345678' }
        end
        it 'works! returns correct status code' do
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'POST /login' do
        before(:example) do
            post '/api/v1/auth/login', params: { email: 'mustafa@gmail.com', password: '12345678' }
        end
        it 'works! returns unauthorized status code' do
            expect(response).to have_http_status(:unauthorized)
        end
    end
end
