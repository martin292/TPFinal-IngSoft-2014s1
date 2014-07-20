Feature: Notify event
  As a system
  I want to notify the speakers if they received new rates

  Background:
    Given I am logged in
    And I am on "the new event page"
    And I fill in "event[name]" with "evento a notificar"
    And I fill in "event[date]" with today
    And I fill in "event[max]" with "10" 
    And I press "saveButton"
    And I am logged out

  Scenario: Event without notifications
    Given I am logged in
    Then I shouldn't see "Hay nuevas evaluaciones"

  Scenario: Event with notifications
    Given I want to rate "evento a notificar"
    When I follow "happyButton"
    And I wait a while    
    And I am logged in
    Then I should see "Hay nuevas evaluaciones"
    And I am on "my events page"
    Then I should see "evento a notificar Hay nuevas evaluaciones"
