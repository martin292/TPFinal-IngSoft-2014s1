Feature: Rate event
  As an attendee
  I want to rate an event
  So the speaker can improve his performance

  Background:
    Given event named "first event" with date today
    And event named "future event" with date tomorrow
    And event named "event with members" with date today and 2 members
    And event named "event without members" with date today

  Scenario: Happy path
    Given I want to rate "first event"
    And I fill in "comment" with "Great!"
    When I follow "happyButton"
    And I wait a while    
    Then I should see "Gracias"

  Scenario: Rate future event
    Given I want to rate "future event"
    And I wait a while    
    Then I should see "El evento no se encuentra disponible para evaluar porque no ha sido dictado"

  Scenario: Rate event with members
    Given I want to rate "event with members"
    When I follow "happyButton"
    And I wait a while
    Then I should see "Gracias"
    Given I want to rate "event with members"
    When I follow "happyButton"
    And I wait a while
    Then I should see "Gracias"
    Given I want to rate "event with members"
    Then I should see "Este evento alcanzo la cantidad maxima de evaluaciones"

  Scenario: Rate event without members
    Given I want to rate "event without members"
    When I follow "happyButton"
    And I wait a while
    Then I should see "Gracias"
    Given I want to rate "event without members"
    When I follow "happyButton"
    And I wait a while
    Then I should see "Gracias"
