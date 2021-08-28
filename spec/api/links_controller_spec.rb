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

  describe 'GET /urls/:short_url/stats' do
    context 'when link is existed by short url' do
      let!(:link) { create(:link, short_url: 'abcd') }
      let(:short_url) { 'abcd' }

      before do
        create(:request, link: link, ip: '100.100.100.100')
        create(:request, link: link, ip: '120.120.120.120')

        get "/urls/#{short_url}/stats"
      end

      it 'return count of requests by link' do
        expect(resp_data).to include(
          'count_uniq_redirections' => 2
        )
      end
    end

    context 'when link is not existed by short url' do
      let!(:another_link) { create(:link, short_url: 'another_short_url') }
      let(:short_url) { 'abcd' }
      before do
        create(:request, link: another_link, ip: '100.100.100.100')

        get "/urls/#{short_url}/stats"
      end

      it 'return status not_found' do
        expect(response).to have_http_status :not_found
      end
    end
  end
end
