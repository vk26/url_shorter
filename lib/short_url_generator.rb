class ShortUrlGenerator
  DEFAULT_LENGTH = 7

  def self.run(params = {})
    new(params).run
  end

  def initialize(params)
    @length = params[:length] || DEFAULT_LENGTH
  end

  attr_reader :length

  def run
    SecureRandom.base58(length)
  end
end
