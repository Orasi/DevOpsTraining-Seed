class ScreenshotsController < ApplicationController

  skip_before_action :require_user_token
  before_filter :allow_cors

  def allow_cors
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET}.join(",")
    headers["Access-Control-Allow-Headers"] =
        %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")

    head(:ok) if request.request_method == "OPTIONS"
    # or, render text: ''
    # if that's more you
  end

  def show
    sst = ScreenshotToken.find_by_token(params[:token])

    render json: {error: "Screenshot not found"},
           status: :not_found and return unless sst

    render json: {error: "Screenshot token has expired"},
           status: :unauthorized and return if sst.expiration < DateTime.now

    ss = sst.screenshot.screenshot
    sst.destroy

    send_file sst.screenshot.screenshot.path, :type => sst.screenshot.screenshot.content_type, :disposition => 'inline' and return

  end
end
