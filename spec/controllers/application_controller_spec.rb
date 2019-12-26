require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let!(:user) { create(:user) }
  let(:token) { create(:token, user_id: user.id) }
  let(:headers) { { Authorization: "bearer #{token.access_token}" } }
  let(:invalid_headers) { { Authorization: nil } }

  describe '#authorize_request' do
    context 'when auth token is passed' do
      before { allow(request).to receive(:headers).and_return(headers) }

      # private method authorize_request returns current user
      it 'sets the current user' do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end
    end

    context 'when auth token is not passed' do
      before { allow(request).to receive(:headers).and_return(invalid_headers) }

      it 'raises InvalidTokenError' do
        expect { subject.instance_eval { authorize_request } }.to raise_error(ExceptionHandler::InvalidTokenError, /Missing token/)
      end
    end
  end
end