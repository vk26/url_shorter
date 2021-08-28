require 'rails_helper'

RSpec.describe 'LinksController', type: :request do
  describe 'POST /urls' do
    before do 
      post '/urls', params: params
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

  describe 'GET /urls/:short_url' do
    context 'when link is existed by short url' do
      let!(:link) { create(:link, short_url: 'abcd', url: 'http://example.com') }
      let(:short_url) { 'abcd' }

      before do
        get "/urls/#{short_url}"
      end

      it 'redirect to target url' do
        expect(response).to redirect_to link.url
      end
    end

    context 'when link is not existed by short url' do
      let!(:link) { create(:link, short_url: 'another_short_url', url: 'http://example.com') }
      let(:short_url) { 'abcd' }

      before do
        get "/urls/#{short_url}"
      end

      it 'returns http 404' do
        expect(response).to have_http_status :not_found
      end
    end
  end
end
