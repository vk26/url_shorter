class Link < ApplicationRecord
  ShortLinkGenerationException = Class.new(StandardError)

  has_many :requests, dependent: :destroy

  validates_presence_of :url, :short_url
  validates :url, url: true
  validates :short_url, uniqueness: true, strict: ShortLinkGenerationException
end
