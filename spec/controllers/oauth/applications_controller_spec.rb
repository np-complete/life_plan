require 'rails_helper'

RSpec.describe Oauth::ApplicationsController, type: :controller do
  let(:user) { create :user }
  shared_examples_for :require_login do
    it do
      request!
      expect(response).not_to be_success
    end
  end

  describe 'GET #index' do
    let(:request!) { get :index }
    it_behaves_like :require_login

    it do
      sign_in user
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    let(:request!) { get :new }
    it_behaves_like :require_login

    it do
      sign_in user
      get :new
      expect(assigns(:application)).to be_a_new Doorkeeper::Application
    end
  end

  describe 'POST #create' do
    let(:attrs) { {} }
    let(:request!) { post :create, doorkeeper_application: attrs }
    it_behaves_like :require_login
    context 'valid' do
      before { sign_in user }
      let(:attrs) { attributes_for :application }
      it do
        expect { request! }.to change { Doorkeeper::Application.count }.by(1)
      end
      it do
        request!
        expect(assigns(:application).owner).to eq user
      end
    end

    context 'invalid' do
      let(:attrs) { { name: '' } }
      it do
        sign_in user
        request!
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    let(:attrs) { {} }
    let(:application) { create :application, owner: user }
    let(:request!) { put :update, id: application.id, doorkeeper_application: attrs }
    it_behaves_like :require_login

    context 'valid' do
      let(:attrs) { attributes_for :application }

      it do
        sign_in user
        request!
        expect { application.reload }.to change { application.name }.to(attrs[:name])
      end
    end

    context 'invalid' do
      let(:attrs) { { name: '' } }
      it do
        sign_in user
        request!
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:application) { create :application, owner: user }
    let(:request!) { delete :destroy, id: application.id }
    it_behaves_like :require_login
    it do
      sign_in user
      expect { request! }.to change { Doorkeeper::Application.count }.by(-1)
    end
  end
end
