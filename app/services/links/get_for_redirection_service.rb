module Links
  class GetForRedirectionService < BaseService
    option :short_url
    option :ip

    attr_reader :link

    def call
      @link = Link.find_by_short_url(short_url)
      if link
        create_request!
        Success(link)
      else
        Failure(:not_found_link)
      end
    end

    private
    
    def create_request!
      Request.create!(link: link, ip: ip)
    end
  end
end
