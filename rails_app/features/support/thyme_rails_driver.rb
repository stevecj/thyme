# Not sure why Bundler doesn't make this happen.
require 'timecop'

# Subclassing Cucumber::Rails::World because that proved
# to give us the rspec matchers, but not sure if that's the
# appropriate thing to do.
class ThymeRailsDriver < Cucumber::Rails::World
  TimeNow = Time.parse('Aug 1, 2012 10:00 AM')

  def initialize(cuke_env)
    @cuke_env = cuke_env
    travel_to_time TimeNow
  end

  def teardown
    back_to_the_present
  end

  def access_activity_time_console
    @cuke_env.visit '/'
  end

  def see_time_entry_grid_for_this_week
    columns = (1..7).map{|n| "#date_col#{n}" }
    [
      'Jul 30, 2012' ,
      'Jul 31, 2012' ,
      'Aug 1, 2012' ,
      'Aug 2, 2012' ,
      'Aug 3, 2012' ,
      'Aug 4, 2012' ,
      'Aug 5, 2012'
    ].each_with_index do |date_text, i|
      col_num = i+1
      @cuke_env.page.within "#date_col#{col_num}" do
        @cuke_env.page.should have_content(date_text)
      end
    end
  end

  private

  def back_to_the_present
    time_travel_return while @time_travels > 0
  end

  def travel_to_time(*args)
    Timecop.travel *args
    @time_travels ||= 0
    @time_travels += 1
  end

  def time_travel_return
    Timecop.return
    @time_travels ||= 0
    @time_travels -= 1
  end
end
