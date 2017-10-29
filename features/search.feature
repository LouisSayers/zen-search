Feature: Search json file

  Scenario: Searching a json file for a specific user
    Given JSON test files exist at 'test_data/search/'
    And commands exist in the '../lib/commands' directory
    And ZenSearch is loaded
    And the 'Load JSON file' option is chosen
    And the 'users-for-search-feature.json' file is loaded
    And the 'Search' option is chosen
    And the search term 'Alias' is entered
    And the search value 'Miss Buck' is entered
    And the exit command has been given
    Then ZenSearch has run
    And JSON value with key '_id', value 3 is printed
