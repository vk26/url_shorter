module Links
  class CreateService < BaseService
    option :url
    option :generator, default: -> { ShortUrlGenerator }
    option :domain, default: -> { ENV['DOMAIN_URL_SHORTENER'] }

    def call
      begin
        link = Link.new(url: url, short_url: new_short_url)
        link.save!
      rescue Link::ShortLinkGenerationException, ActiveRecord::RecordNotUnique => e
        retry 
      rescue ActiveRecord::RecordInvalid => e
        return Failure(link.errors)        
      end

      Success(prepare_short_url(link.short_url))
    end

    private

    def new_short_url
      generator.run
    end

    def prepare_short_url(short_url)
      "#{domain}/urls/#{short_url}"
    end
  end
end
