class Thyme
  def initialize(options)
  end

  def access_activity_time_entry(controller)
    controller.show_activity_time_entry( [
      { :date => Date.civil(2012, 7, 30), :entries => [] },
      { :date => Date.civil(2012, 8,  1), :entries => [] },
      { :date => Date.civil(2012, 8,  2), :entries => [] },
      { :date => Date.civil(2012, 8,  3), :entries => [] },
      { :date => Date.civil(2012, 8,  4), :entries => [] },
      { :date => Date.civil(2012, 8,  5), :entries => [] },
      { :date => Date.civil(2012, 8,  6), :entries => [] }
    ] )

  end
end

def thyme
  @thyme ||= Thyme.new(
    :date_source => proc{ today }
  )
end

def today
  Date.civil(2012, 8, 1)
end

class Controller
  attr_reader :response

  def show_activity_time_entry(response)
    @response = response
  end
end

def controller
  @controller ||= Controller.new
end

def access_activity_time_entry
  thyme.access_activity_time_entry controller
end

def see_time_entry_grid_for_this_week
  controller.response.should == [
    { :date => Date.civil(2012, 7, 30), :entries => [] },
    { :date => Date.civil(2012, 8,  1), :entries => [] },
    { :date => Date.civil(2012, 8,  2), :entries => [] },
    { :date => Date.civil(2012, 8,  3), :entries => [] },
    { :date => Date.civil(2012, 8,  4), :entries => [] },
    { :date => Date.civil(2012, 8,  5), :entries => [] },
    { :date => Date.civil(2012, 8,  6), :entries => [] }
  ]
end
