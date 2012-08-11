Given /^I am at the time entry console$/ do
  driver.access_activity_time_console
end

When /^I access the time entry console$/ do
  driver.access_activity_time_console
end

When /^I make an activity time entry for today$/ do
  driver.make_an_activity_time_entry_for_today
end

Then /^I see the time entry grid for this week$/ do
  driver.see_time_entry_grid_for_this_week
end

Then /^I see the activity time entry in the grid$/ do
  driver.see_time_entry_in_grid
end
