When /^Access the time entry feature$/ do
  driver.access_activity_time_console
end

Then /^I see the time entry grid for this week$/ do
  driver.see_time_entry_grid_for_this_week
end
