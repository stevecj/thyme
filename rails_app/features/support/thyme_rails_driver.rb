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
        @cuke_env.page.should have_content date_text
      end
    end
  end

  def make_an_activity_time_entry_for_today
    within_column_for_today do
      click_add_new
    end
    see_activity_time_entry_form

    @date_for_time_entry = 'Aug 1, 2012'
    @the_time_entry_data = typical_activity_time_entry_data
    fill_in_activity_time @the_time_entry = typical_activity_time_entry_data

    within_activity_time_form do
      submit_form
    end
  end

  def see_time_entry_in_grid
    within_date_column_for @date_for_time_entry do
      # No timing safety protection. Currently doesn't matter.
      time_entries_data.should include(@the_time_entry)
    end
  end

  private

  def within_column_for_today
    @cuke_env.within '#date_col3' do
      sanity_check{ @cuke_env.page.should have_content 'Aug 1, 2012' }
      yield
    end
  end

  def click_add_new
    @cuke_env.find('.add-new').click
  end

  def activity_time_form_selector
    '.new_activity_time_span_form'
  end

  def see_activity_time_entry_form
    selector = activity_time_form_selector
    @cuke_env.find(selector)
  rescue Capybara::ElementNotFound => e
    raise_component_not_found "the activity time entry form", selector
  end

  def typical_activity_time_entry_data
    {:from_time=>'10:30 AM', :to_time=>'12:15 PM', :activity=>'Weed whacking'}
  end

  def within_activity_time_form
    @cuke_env.within activity_time_form_selector do
      yield
    end
  end

  def fill_in_activity_time(data)
    within_activity_time_form do
      @cuke_env.find( '.from_time').set data[ :from_time ]
      @cuke_env.find( '.to_time'  ).set data[ :to_time   ]
      @cuke_env.find( '.activity' ).set data[ :activity  ]
    end
  end

  def sanity_check
    yield
  end

  def submit_form
    @cuke_env.find('input[type=submit]').click
  end

  def within_date_column_for(date)
    selector = '.date-column'
    column = begin
      @cuke_env.find(selector, :text=>date)
    rescue Capybara::ElementNotFound => e
      raise_component_not_found "the date column", selector
    end
    @cuke_env.within column do
      yield
    end
  end

  def time_entries_data
    @cuke_env.all('.entry').map{ |entry|
      {
        :from_time => @cuke_env.find('.from-time' ).text ,
        :to_time   => @cuke_env.find('.to-time'   ).text ,
        :activity  => @cuke_env.find('.activity'  ).text
      }
    }
  end

  def raise_component_not_found(name, selector)
    raise \
      "Did not find #{name.inspect} with #{selector.inspect} on page " +
      "at #{@cuke_env.current_path.inspect} with status " +
      "#{@cuke_env.page.driver.status_code} containing..."
    # If we ever want to show page content in the message, we can
    # include something like ... @cuke_env.page.body.lines.take(40) * ''
  end

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
