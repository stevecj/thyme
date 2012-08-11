class ApplicationController < ActionController::Base
  module Direction
    def show_time_entry_console
      controller.redirect_to :controller => :time_entries, :action => :index
    end
  end

  protect_from_forgery

  private

  def thyme
    @thyme ||= ThymeOnRails::Application.config.thyme_builder.call.tap do |t|
      t.director.extend Direction
      _controller = self
      t.director.define_singleton_method(:controller){ _controller }
    end
  end
end
