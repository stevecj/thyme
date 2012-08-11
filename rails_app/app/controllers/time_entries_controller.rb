class TimeEntriesController < ApplicationController
  def index
    thyme.show_activity_time_console method(:render_index)
  end

  def new
    @on_date = params[:on_date]
  end

  def create
    thyme.submit_activity_time_span params[:activity_time_span]
  end

  def render_index(data)
    #TODO: This belongs to a presenter role, eh?
    date_strings = data.map{|date_col| date_col[:date].strftime('%b %-d, %Y') }

    @date_cols = date_strings.each_with_index.map{|ds,i|
      {:id => "date_col#{i+1}", :date => ds}
    }
  end
end
