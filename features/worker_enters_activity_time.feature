Feature: Worker enters activity time
  In order to keep track of time spent of various activities
  As a worker
  I want to record activities worked on over spans of time

  Scenario: View this week's time entry grid
    When I access the time entry console
    Then I see the time entry grid for this week

  @wip
  Scenario: Enter activity time for today
    Given I am at the time entry console
    When I make an activity time entry for today
    Then I see the activity time entry in the grid
