Feature: Worker enters activity time
  In order to keep track of time spent of various activities
  As a worker
  I want to record activities worked on over spans of time

  Scenario: View this week's time entry grid
    When Access the time entry feature
    Then I see the time entry grid for this week
