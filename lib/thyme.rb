require 'date'

class Thyme
  class Director
  end

  def initialize(persistence, options = {})
    @options = options
    @persistence = persistence
    @director = Director.new
  end

  def director
    @director
  end

  def show_activity_time_console(renderer)
    data = dates_in_week_of(today).map{|date|
      { :date => date, :entries => @persistence.activity_time_entries_on(date) }
    }
    renderer.call data
  end

  def submit_activity_time_span(data)
    @persistence.add_activity_time_span data
    director.show_time_entry_console
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
