require 'rails_helper'

RSpec.describe Link, type: :model do
  subject { Link.create(params) }

  describe 'validations' do
    context 'with valid url' do
      let(:params) { { url: 'https://example.com/about', short_url: 'abcDEF' } }
      it { is_expected.to be_valid }
    end

    context 'with valid url' do
      let(:params) { { url: 'incorrect_url', short_url: 'abcDEF' } }
      it { is_expected.to_not be_valid }
    end

    context 'without short_url' do
      let(:params) { { url: 'https://example.com/about', short_url: nil } }
      it { is_expected.to_not be_valid }
    end
  end

  describe '#stats' do
    context 'when requests are existed by link' do
      let(:link) { create(:link, short_url: 'abc') }
      let(:another_link) { create(:link, short_url: 'def') }

      before do
        create(:request, link: link, ip: '20.20.20.20')
        create(:request, link: link, ip: '20.20.20.20')
        create(:request, link: link, ip: '30.30.30.30')
        create(:request, link: link, ip: '30.30.30.30')

        create(:request, link: another_link, ip: '20.20.20.20')
      end

      it 'return count_uniq_redirections' do
        expect(link.stats).to include(
          count_uniq_redirections: 2
        )
      end
    end

    context 'when requests are not existed by link' do
      let(:link) { create(:link, short_url: 'abc') }
      let(:another_link) { create(:link, short_url: 'def') }

      before do
        create(:request, link: another_link, ip: '20.20.20.20')
      end

      it 'return zero count_uniq_redirections' do
        expect(link.stats).to include(
          count_uniq_redirections: 0
        )
      end
    end
  end
end
