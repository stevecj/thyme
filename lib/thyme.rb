require 'date'

class Thyme
  def initialize(options = {})
    @options = options
  end

  def show_activity_time_console(renderer)
    data = dates_in_week_of(today).map{|date|
      { :date => date, :entries => [] }
    }
    renderer.call data
  end

  private

  def today
    @date_source ||= ( @options[:date_source] || Date.method(:today) )
    @date_source.call
  end

  def dates_in_week_of(date_in_week)
    monday = date_in_week + 1 - date_in_week.cwday
    sunday = monday + 6
    (monday..sunday)
  end
end
