require 'spec_helper'

describe User do
  describe 'user info' do
       context 'unvalid data' do
      it 'unvalid without city' do
        expect(build(:user, city:nil)).to have(1).errors_on(:city)
      end

      it 'unvalid without name' do
        expect(build(:user,first_name:nil)).to have(1).errors_on(:first_name)
      end
    end
  end

  describe 'user session' do
    it 'should have session_token' do
      expect(build(:user,session_token:nil)).not_to be_valid
    end
    it 'session_token must be uniqence' do
      create(:user,session_token:'asdf')
      expect(build(:user,session_token:'asdf')).to have(1).errors_on(:session_token)
    end
  end

end