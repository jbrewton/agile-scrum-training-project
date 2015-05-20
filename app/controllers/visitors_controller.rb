class VisitorsController < ApplicationController
  def index
    redirect_to tasks_path and return if user_signed_in?
  end
end
