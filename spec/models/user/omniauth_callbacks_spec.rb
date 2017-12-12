require 'rails_helper'

describe User::OmniauthCallbacks, type: :model do
  let(:data) { { 'email' => 'email@example.com', 'nickname' => 'baodongdong', 'name' => 'baodongdong' } }
  let(:uid) { '428' }
  let(:callback) { User.include(User::OmniauthCallbacks) }
  describe 'new_from_provider_data' do
    it 'should respond to :new_from_provider_data' do
      expect(callback).to respond_to(:new_from_provider_data)
    end
  end
end
