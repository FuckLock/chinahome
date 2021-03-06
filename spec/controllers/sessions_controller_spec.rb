require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET new' do
    before { request.env['devise.mapping'] = Devise.mappings[:user] }
    it "renders the new template" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    let(:user) { create(:user) }
    before { request.env['devise.mapping'] = Devise.mappings[:user] }
    it 'login a user and redirects to root path' do
      post :create, params: { user: { login: user.login, password: user.password } }
      expect(response).to redirect_to(root_path)
    end
  end
end
