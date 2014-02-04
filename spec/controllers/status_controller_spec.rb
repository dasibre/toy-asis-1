require 'spec_helper'

describe StatusController do
  let(:authorization_service) { double('AuthorizationService') }

  before do
    controller.stub(:authorization_service => authorization_service)
  end

  describe '#show' do
    it 'authorizes using manuscript and provided author' do
      manuscript = double('Manuscript')
      expect(Manuscript).to receive(:find_by_code).with('SOMECODE').and_return(manuscript)
      expect(authorization_service).to receive(:accept?).with(manuscript, 'foo')
      get :show, :code => 'SOMECODE', :author => 'foo'
    end

    context 'with unauthorized' do
      before do
        authorization_service.stub(:accept? => false)
        get :show
      end

      it 'renders :new template' do
        expect(response).to render_template(:new)
      end

      it 'assigns @authorization_error' do
        expect(assigns[:authorization_error]).to be_true
      end
    end

    context 'with authorized' do
      before do
        authorization_service.stub(:accept? => true)
        get :show
      end

      it 'renders :show template' do
        expect(response).to render_template(:show)
      end
    end
  end
end
