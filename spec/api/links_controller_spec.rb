require 'rails_helper'

RSpec.describe 'LinksController', type: :request do
  describe 'POST /url' do
    before do 
      post '/url', params: params
    end

    context 'with valid params' do
      let(:params) { { url: 'https://example.com/about' } }
      let(:link) { Link.last }

      it 'returns http success' do
        expect(response).to have_http_status :created
      end
      
      it 'return short url' do
        expect(resp_data).to include('short_url')
      end
      
      it 'create link' do
        expect(link.url).to eq params[:url]
      end
    end

    context 'with invalid params' do
      let(:params) { { url: 'incorrect_url' } }

      it 'returns http status bad_request' do
        expect(response).to have_http_status :bad_request
      end

      it 'returns errors' do
        expect(resp_errors).to include(
          'url' => ['is not a valid URL']
        )
      end
    end
  end
end
