class Link < ApplicationRecord
  has_many :requests, dependent: :destroy

  validates :url, presence: true, url: true
  validates :short_url, presence: true, uniqueness: true
end
