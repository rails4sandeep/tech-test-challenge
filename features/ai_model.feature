@ai_model
Feature: AI Model

  Scenario: Receive request from webservice with processed images
    Given the AI model received the request with processed images
    When the images are processed by the AI model
    Then the AI model should update the database

  Scenario: Images received corrupt
    Given the AI model received the request with processed images
    When the images received are not corrupted
    Then the AI model should return an error response back to the webservice

  Scenario: Empty request received with no images
    Given the AI model received the request with processed images
    When the images referred in the payload are missing
    Then the AI model should return an error response back to the webservice

  Scenario: Invalid token
    Given the AI model received the request with processed images
    When the request has an invalid token
    Then the AI model should return an error message back to the webservice

  Scenario: Request received with invalid payload
    Given the AI model received request with processed images
    When the request payload is not in expected format
    Then the AI model should return an error message back to the webservice

  Scenario: Timeout communicating with database
    Given the AI model received the request with processed images
    And the AI model processed the images
    When the AI model triggers an update to the database
    And the update timed out
    Then the AI model should trigger a rollback of the update

  Scenario: Error received from database
    Given the AI model received the request with processed images
    And the AI model processed the images
    When the AI model triggers an update to the database
    And the update returned an error
    Then the AI model should trigger a rollback of the update

