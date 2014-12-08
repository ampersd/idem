require 'spec_helper'

describe BaseController,type: :controller do

  # залогиненые пользователи
  context 'authorize user' do
    # перед каждым тестом создаем пользователя
    before(:each) do
      @user = create(:user)
      allow(controller).to receive(:current_user=).with(@user)
    end

    it 'if user are auth redirect to index' do
      expect(allow(controller).to receive(:user_auth?)).to be_truthy
      get :start
      expect(response).to redirect_to home_path
    end

  end

  context 'not autorize user' do
    before(:each) do
      allow(controller).to receive(:log_out)
    end
    it 'GET #start should render index_teplate' do
      get :start
      expect(response).to render_template :start
    end

    it 'if user not auth must open start page' do
      visit root_path
      expect(page).to render_template :start
    end
  end

end