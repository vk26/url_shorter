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

    context 'double link with same short_url' do
      let(:params) { { url: 'https://example.com/another', short_url: 'abcDEF' } }
      let(:new_link) { build(:link, short_url: subject.short_url) }

      it 'new link is not be valid' do
        expect(new_link).to_not be_valid
      end
    end
  end
end
