require 'date'

class Thyme
  def initialize(options = {})
    @options = options
  end

  def today
    @date_source ||= ( @options[:date_source] || Date.method(:today) )
    @date_source.call
  end

  def dates_in_week_of(date_in_week)
    monday = date_in_week + 1 - date_in_week.cwday
    sunday = monday + 6
    (monday..sunday)
  end

  def access_activity_time_entry(controller)
    response = dates_in_week_of(today).map{|date|
      { :date => date, :entries => [] }
    }
    controller.show_activity_time_entry response
  end
end
