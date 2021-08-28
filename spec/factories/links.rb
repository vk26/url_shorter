FactoryBot.define do
  factory :link do
    short_url { 'abcDEF123' }
    url { 'http://example.com/about' }
  end
end
