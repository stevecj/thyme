class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def thyme
    ThymeOnRails::Application.config.thyme
  end
end
