Feature: Worker records activity time
  In order to keep track of time spent on various activities
  As a worker
  I want to record and retrieve ranges of activity time

  Scenario: Worker records and retrieves activity time ranges
    When I submit some activity time ranges
    Then I should have access to the submitted activity time data
