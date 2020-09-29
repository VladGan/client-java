Feature: Debugging Space

  Background: Initialise a session and transaction for each scenario
    Given connection has been opened
    Given connection delete all keyspaces
    Given connection open sessions for keyspaces:
      | test_rule_validation |
    Given transaction is initialised
    Given graql define
      """
      define
      person sub entity, plays employee, has name, key email;
      employment sub relation, relates employee, has start-date;
      name sub attribute, value string;
      email sub attribute, value string;
      start-date sub attribute, value datetime;
      """
    Given the integrity is validated
  # Paste any scenarios below for debugging.
  # Do not commit any changes to this file.

  Scenario: When defining a rule with a variable atom type, an error is thrown.
    Given graql define
      """
      define

      element sub entity,
      plays first,
      plays second;

      symmetric sub relation,
      relates first,
      relates second;
      """

    Given the integrity is validated
    Then graql define throws

      """
      define
      symmetry sub rule,
      when {
          $s sub symmetric;
          (first: $a, second: $b) isa $s;
      }, then {
          (first: $b, second: $a) isa $s;
      };
      """
    Then the integrity is validated