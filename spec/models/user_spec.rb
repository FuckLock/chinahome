require 'rails_helper'
require 'digest/md5'

describe User, type: :model do

  let(:user)  { create :user }

  describe 'login format' do
    context 'baodongdong' do
      let(:user) { build(:user, login: 'baodongdong') }
      it { expect(user.valid?).to eq true }
    end

    context 'baodongdong-github' do
      let(:user) { build(:user, login: 'baodongdong-github') }
      it { expect(user.valid?).to eq true }
    end

    context 'baodongdong-12123' do
      let(:user) { build(:user, login: 'baodongdong-12123') }
      it { expect(user.valid?).to eq true }
    end

    context '12345' do
      let(:user) { build(:user, login: '12345') }
      it { expect(user.valid?).to eq true }
    end

    context 'baodongdong.github' do
      let(:user) { build(:user, login: 'baodongdong.github') }
      it { expect(user.valid?).to eq true }
    end

    context 'BAODONGDONG' do
      let(:user) { build(:user, login: 'BAODONGDONG') }
      it { expect(user.valid?).to eq true }
    end

    context 'll&&^12' do
      let(:user) { build(:user, login: '*ll&&^12') }
      it { expect(user.valid?).to eq false }
    end

    context 'abdddddc$' do
      let(:user) { build(:user, login: 'abdddddc$') }
      it { expect(user.valid?).to eq false }
    end

    context '$abdddddc' do
      let(:user) { build(:user, login: '$abdddddc') }
      it { expect(user.valid?).to eq false }
    end

    context 'aaa*11' do
      let(:user) { build(:user, login: 'aaa*11') }
      it { expect(user.valid?).to eq false }
    end

    describe 'Login allow upcase and downcase' do
      let(:user1) { create(:user, login: 'ReiIs123') }
      it 'successful valid user info' do
        expect(user1.login).to eq('ReiIs123')
        expect(User.find_by_login('ReiIs123').id).to eq(user1.id)
        expect(User.find_by_login('reiis123').id).to eq(user1.id)
        expect(User.find_by_login('rEIIs123').id).to eq(user1.id)
      end
    end
  end

  describe 'email and email_md5' do
    it 'generate email_md5 when give value to email attribute' do
      user.email = 'fooaaaa@gmail.com'
      user.save
      expect(user.email_md5).to eq(Digest::MD5.hexdigest('fooaaaa@gmail.com'))
      expect(user.email).to eq('fooaaaa@gmail.com')
    end
  end
end
