require 'rails_helper'

RSpec.describe Links::CreateService do
  subject { described_class.new(params).call }

  let(:generator_stub) { double('generator') }
  let(:new_link) { Link.last }

  context 'with correct params' do
    before do
      allow(generator_stub).to receive(:run) { 'abc' }
    end

    let(:params) { { url: 'https://example.com', generator: generator_stub } }

    it { is_expected.to be_success }
    
    it 'create link with url and generated short_url' do
      subject
      expect(new_link).to have_attributes(url: params[:url], short_url: 'abc')      
    end
  end

  context 'when link with same short_url is exists' do
    let(:params) { { url: 'https://example.com', generator: generator_stub } }
    
    it 'generate new short_url' do
      create(:link, short_url: 'abc')
      allow(generator_stub).to receive(:run) { %w[abc def].sample }
      subject
      expect(new_link).to have_attributes(url: params[:url], short_url: 'def')      
    end
  end

  context 'with invalid params' do
    let(:params) { { url: 'incorrect_url' } }

    it { is_expected.to be_failure }
  end
end
