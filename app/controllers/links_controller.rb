class LinksController < ApplicationController
  def create 
    result = Links::CreateService.new(url: params[:url]).call

    if result.success?
      render json: { data: { short_url: result.success } }, status: :created
    else
      render json: { errors: result.failure }, status: :bad_request
    end
  end

  def redirect
    result = Links::GetForRedirectionService.new(
      short_url: params[:short_url],
      ip: request.remote_ip
    ).call
    
    if result.success?
      redirect_to result.success.url
    else
      render json: { errors: "Url with short url #{params[:short_url]} is not found" }, status: :not_found
    end
  end

  def stats
    link = Link.find_by_short_url(params[:short_url])
    if link
      render json: { data: link.stats }
    else
      render json: { errors: "Url with short url #{params[:short_url]} is not found" }, status: :not_found
    end
  end
end
