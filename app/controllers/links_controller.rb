class LinksController < ApplicationController
  def create
    result = Links::CreateService.new(
      url: link_params[:url]
    ).call

    if result.success?
      render json: { data: result.success }, status: :created
    else
      render json: { errors: result.failure }, status: :bad_request
    end
  end

  private

  def link_params
    params.permit(:url)
  end
end
