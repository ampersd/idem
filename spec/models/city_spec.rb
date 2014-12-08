require 'spec_helper'

describe City do
  before(:each) do
    create(:first_city)
    @user1 = create(:user,city_id:1)
    @user2 = create(:user,city_id:1)
    @user3 = create(:user)
  end
  it 'should have users' do

    expect(City.find(1).users).to match_array([@user1,@user2])
  end

  it 'should be unvalid without title' do
    expect(build(:city,title:nil)).not_to be_valid
  end

  it 'should be unvalid without id' do
    expect(build(:city,id:nil)).not_to be_valid
  end

end