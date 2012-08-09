class ThymeDomainDriver
  def initialize(cuke_env)
  end

  def teardown
  end

  def access_activity_time_console
    app.show_activity_time_console method(:render_activity_time_console)
  end

  def see_time_entry_grid_for_this_week
    @activity_time_console_data.should == [
      { :date => Date.civil(2012, 7, 30), :entries => [] },
      { :date => Date.civil(2012, 7, 31), :entries => [] },
      { :date => Date.civil(2012, 8,  1), :entries => [] },
      { :date => Date.civil(2012, 8,  2), :entries => [] },
      { :date => Date.civil(2012, 8,  3), :entries => [] },
      { :date => Date.civil(2012, 8,  4), :entries => [] },
      { :date => Date.civil(2012, 8,  5), :entries => [] }
    ]
  end

  private

  def today
    Date.civil(2012, 8, 1)
  end

  def app
    require_relative '../../lib/thyme'

    @app ||= Thyme.new(
      :date_source => proc{ today }
    )
  end

  def render_activity_time_console(data)
    @activity_time_console_data = data
  end
end
