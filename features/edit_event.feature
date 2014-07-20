Feature: Edit event
  As a speaker
  I want edit a event
  To modify the dataof the event

  Background:
    Given I am logged in
    And I am on "the new event page"
    And I fill in "event[name]" with "Mi primer evento"
    And I fill in "event[max]" with "10"
    And I fill in "event[date]" with tomorrow
    And I fill in "event[members]" with "miembro1@gmail.com, miembro2@outlook.com, miembro3@yahoo.com"
    And I press "saveButton"

  Scenario: Add member
    Given I am browsing the edit page for event with slug "miprimerevento1"
    And I add the member "miembro4@hotmail.com"
    And I press "saveButton"
    And I wait a while
    Then I should see "miembro1@gmail.com, miembro2@outlook.com, miembro3@yahoo.com, miembro4@hotmail.com"

  Scenario: Remove member
    Given I am browsing the edit page for event with slug "miprimerevento1"
    And I remove the member "miembro3@yahoo.com"
    And I press "saveButton"
    And I wait a while
    Then I shouldn't see "miembro3@yahoo.com"
