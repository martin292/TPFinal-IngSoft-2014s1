Feature: Create event
  As a speaker
  I want to create a event and get its link
  To share with the audience

  Background:
    Given there are not events
    And I am logged in

  Scenario: Happy path
    Given I am on "the new event page"
    And I fill in "event[name]" with "My first event"
    And I fill in "event[max]" with "10"
    And I fill in "event[date]" with tomorrow
    And I fill in "event[members]" with "miembro1@gmail.com, miembro2@outlook.com, miembro3@yahoo.com"
    When I press "saveButton"
    Then I should see "myfirstevent1"

  Scenario: Event without number of members
    Given I am on "the new event page"
    And I fill in "event[name]" with "My first event"
    And I fill in "event[max]" with " "
    And I fill in "event[date]" with tomorrow
    And I fill in "event[members]" with "miembro1@gmail.com, miembro2@outlook.com, miembro3@yahoo.com"
    When I press "saveButton"
    Then I should see "myfirstevent1"

  Scenario: Event with a number of members with invalid character
    Given I am on "the new event page"
    And I fill in "event[name]" with "My first event"
    And I fill in "event[max]" with "diez"
    And I fill in "event[date]" with tomorrow
    And I fill in "event[members]" with "miembro1@gmail.com, miembro2@outlook.com, miembro3@yahoo.com"
    When I press "saveButton"
    Then I should see "Error: la cantidad de participantes debe ser un numero positivo"

  Scenario: Event with a negative number of members
    Given I am on "the new event page"
    And I fill in "event[name]" with "My first event"
    And I fill in "event[max]" with "-10"
    And I fill in "event[date]" with tomorrow
    And I fill in "event[members]" with "miembro1@gmail.com, miembro2@outlook.com, miembro3@yahoo.com"
    When I press "saveButton"
    Then I should see "Error: la cantidad de participantes debe ser un numero positivo"

  Scenario: Event without members
    Given I am on "the new event page"
    And I fill in "event[name]" with "My first event"
    And I fill in "event[max]" with "10"
    And I fill in "event[date]" with tomorrow
    And I fill in "event[members]" with " "
    When I press "saveButton"
    Then I should see "myfirstevent1"

  Scenario: Event with invalid member
    Given I am on "the new event page"
    And I fill in "event[name]" with "My first event"
    And I fill in "event[max]" with "10"
    And I fill in "event[date]" with tomorrow
    And I fill in "event[members]" with "miembro1.com"
    When I press "saveButton"
    Then I should see "Error"

  Scenario: Event id already exists
    Given I am on "the new event page"
    And event named "My first event" already exists
    And I fill in "event[name]" with "My first event"
    And I fill in "event[max]" with "10"
    And I fill in "event[date]" with tomorrow
    And I fill in "event[members]" with "miembro1@gmail.com, miembro2@outlook.com, miembro3@yahoo.com"
    When I press "saveButton"
    Then I should see "myfirstevent2"

  Scenario: Date is not valid
    Given I am on "the new event page"
    And I fill in "event[name]" with "My first event"
    And I fill in "event[max]" with "10"
    And I fill in "event[date]" with yesterday
    And I fill in "event[members]" with "miembro1@gmail.com, miembro2@outlook.com, miembro3@yahoo.com"
    When I press "saveButton"
    Then I should see "Error"

  Scenario: Name is blank
    Given I am on "the new event page"
    And I fill in "event[name]" with " "
    And I fill in "event[date]" with yesterday
    And I fill in "event[members]" with "miembro1@gmail.com, miembro2@outlook.com, miembro3@yahoo.com"
    When I press "saveButton"
    Then I should see "Error"
