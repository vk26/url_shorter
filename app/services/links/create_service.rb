module Links
  class CreateService < BaseService
    def initialize(params)
      @url = params[:url]
      @generator = params[:generator] || ShortUrlGenerator
    end

    attr_reader :url, :generator

    def call
      begin
        link = Link.new(url: url, short_url: new_short_url)
        link.save!
      rescue Link::ShortLinkGenerationException, ActiveRecord::RecordNotUnique => e
        retry 
      rescue ActiveRecord::RecordInvalid => e
        return Failure(link.errors)        
      end

      Success(link)
    end

    private

    def new_short_url
      generator.run
    end
  end
end
