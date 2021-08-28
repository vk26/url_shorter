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
end
