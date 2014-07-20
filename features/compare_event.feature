Feature: Compare event
  As a speaker
  I want compare events
  To I can see the evolution between them

  Background:
    Given there are not events
    And I am logged in
    And event named "Evento A" with tag "Heroku" exists
    And event named "Evento B" with tag "GitHub" exists
    And event named "Evento C" with tag "Heroku" exists
    
  Scenario: Comparation 
    Given I am on "my events page"
    When I am browsing the comparation page for event with tag "GitHub"
    Then I should see "Este evento no se puede comparar porque no hay eventos que contengan el mismo tag"

  Scenario: Comparation
    Given I am on "my events page"
    When I am browsing the comparation page for event with tag "Heroku"
    Then I should see "Evento A"
    Then I should see "Evento C"

