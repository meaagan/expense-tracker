class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_budget

  private

  def set_current_budget
    @current_budget = current_user.current_budget if user_signed_in?
  end
end
