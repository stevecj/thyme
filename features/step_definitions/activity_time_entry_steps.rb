When /^Access the time entry feature$/ do
  access_activity_time_entry
end

Then /^I see the time entry grid for this week$/ do
  see_time_entry_grid_for_this_week
end
