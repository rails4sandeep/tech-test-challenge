@pre_processor
Feature: Python pre-processor

  Scenario: invalid token
    Given the python preprocessor sends a request with processed images to webservices
    When the request has an invalid token
    Then the webservice should send an error back to the preprocessor

  Scenario: time out
    Given the python preprocessor sends a request with processed images to webservices
    When the request failed to receive acknowledgement within timeout period
    Then preprocessor should mark the request as a failure

  Scenario: error received from webservice
    Given the python preprocessor sends a request with processed images to webservices
    When the request receives an error response from the webservice
    Then preprocessor should mark the request as a failure

  Scenario: valid token and payload
    Given the python preprocessor sends a request with processed images to webservices
    When the request has valid token and payload
    Then the webservice should send an acknowledgement response to the preprocessor

  Scenario: corrupt processed image data
    Given the python preprocessor sends a request with processed images to webservices
    When the processed images are corrupted
    Then the webservice should send an error back to the preprocessor

