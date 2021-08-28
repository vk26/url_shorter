module Links
  class GetForRedirectionService < BaseService
    def initialize(params)
      @short_url = params[:short_url]
      @ip = params[:ip]
    end

    attr_reader :short_url, :ip, :link

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
