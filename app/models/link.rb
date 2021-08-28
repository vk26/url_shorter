class Link < ApplicationRecord
  ShortLinkGenerationException = Class.new(StandardError)

  has_many :requests, dependent: :destroy

  validates_presence_of :url, :short_url
  validates :url, url: true
  validates :short_url, uniqueness: true, strict: ShortLinkGenerationException

  def stats
    {
      count_uniq_redirections: count_uniq_redirections
    }
  end

  private

  def count_uniq_redirections
    requests.distinct.count(:ip)
  end
end
