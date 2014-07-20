Feature: See ratings
  As an speaker
  I want to the rating and average of my events
  So I can improve his performance

  Background:
    Given I am logged in
    And the event named "the first event" and rated with 1
    And event named "evento sin evaluacion" with date today
    And the event named "evento con las mismas calificaciones" and rated with 1 , 3 times
    And the event named "evento con diferentes calificaciones" and rated with 1 , 0 and "-1"

  Scenario: Happy path
    Given I am browsing the ratings page for event with slug "thefirstevent1"
    And I wait a while

  Scenario: Event without ratings
    Given I am browsing the ratings page for event with slug "eventosinevaluacion1"
    And I wait a while
    Then should see "Promedio de evaluaciones: - "

  Scenario: Event with same ratings
    Given I am browsing the ratings page for event with slug "eventoconlasmismascalificaciones1"
    And I wait a while
    Then should see "Promedio de evaluaciones: 10"

 Scenario: Event with differents ratings
    Given I am browsing the ratings page for event with slug "eventocondiferentescalificaciones1"
    And I wait a while
    Then should see "Promedio de evaluaciones: 5"
