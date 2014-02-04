class StatusController < ApplicationController
  def new

  end

  def show
    @manuscript = Manuscript.find_by_code(params[:code])

    unless authorization_service.accept?(@manuscript, params[:author])
      @authorization_error = true
      render :new
    end
  end

  private

  def authorization_service
    AuthorizationService
  end
end
