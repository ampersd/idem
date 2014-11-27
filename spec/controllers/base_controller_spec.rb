require 'spec_helper'

describe BaseController,type: :controller do

  it 'GET #index should render index_teplate' do
    get :index
    expect(response).to render_template :index
  end


end