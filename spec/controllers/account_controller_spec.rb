require 'rails_helper'

describe AccountController, type: :controller do
  describe 'GET new' do
    before { request.env['devise.mapping'] = Devise.mappings[:user] }
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    before { request.env['devise.mapping'] = Devise.mappings[:user] }
    it 'create a user and redirects to the root path' do
      post :create, params: { format: :js, user: { login: 'newlogin', email: 'newlogin@email.com', password: 'password' } }
      expect(response).to be_success
    end
  end
end
