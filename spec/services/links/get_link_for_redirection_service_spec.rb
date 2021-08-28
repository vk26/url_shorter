require 'rails_helper'

RSpec.describe Links::GetForRedirectionService do
  subject { described_class.new(params).call }

  context 'when link is existed' do
    let!(:link) { create(:link, short_url: 'abcd') }
    let(:params) { { short_url: 'abcd', ip: '130.130.130.130' } }
    let(:new_request_record) { Request.last }

    it { is_expected.to be_success }

    it 'return link' do
      expect(subject.success).to eq link
    end

    it 'create request record by link' do
      subject
      expect(new_request_record).to have_attributes(link: link, ip: IPAddr.new(params[:ip]))      
    end
  end

  context 'when link is not existed' do
    let!(:another_link) { create(:link, short_url: 'another_short_url') }
    let(:params) { { short_url: 'abcd', ip: '130.130.130.130' } }
    
    it { is_expected.to be_failure }
  end
end
