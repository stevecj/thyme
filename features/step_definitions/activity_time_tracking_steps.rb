When /^I submit some activity time ranges$/ do
  application.record_activity_time_range from: '11:00', to: '12:15', activity: 'Doodling'
  application.record_activity_time_range from: '12:15', to: '13:15', activity: 'Lunch'
end

Then /^I should have access to the submitted activity time data$/ do
  ranges = application.activity_time_ranges
  ranges.should include( from: '11:00', to: '12:15', activity: 'Doodling' )
  ranges.should include( from: '12:15', to: '13:15', activity: 'Lunch'    )
end
