@webservice
Feature: Webservices

Scenario: unauthenticated request from electron app
Given the webservices received a request from electron app
When the request does not have an valid authenticated token
Then the webservices should send back an error response

Scenario: unexpected payload in the request from electron app
Given the webservices receive a request with a valid token from the electron app
When the request contains payload that does not match the expected contract
Then the webservice should send back an error response

Scenario: missing mandatory data in the request received from the electron app
Given the webservice receive a request with a valid token from the electron app
When the request payload data does not contain mandatory data
Then the webservice should send back an error response

Scenario: timeout receiving data from the db for the request received from the electron app
Given the webservice receive a request with valid token from the electron app
And the request payload contains the required data
When the webservice receives timeout from the DB when processing this data
Then the webservice should send back a timeout response back to the electron app

Scenario: error receiving data from the db for the request received from the electron app
Given the webservice receive a request with valid token from the electron app
And the request payload contains the required data
When the webservice receives an error from the database when processing this data
Then the webservice should send back an error response back to the electron app

Scenario: valid data received from the db for the request received from the electron app
Given the webservice receive a request with valid token from the electron app
When the data contains all the required data in the payload 
Then the webservice should send back a response after processing the data

Scenario: timeout to receive response from AI model for request with processed images data
Given the webservice receive a request with processed images from python pre-processor
And the webservice sends the data to the AI model
When the webservice timed out receiving any response from the AI model
Then the webservice should send an error response to the python pre-processor

Scenario: error message received from AI model for request with processed images data
Given the webservice receive a request with processed images from python pre-processor
And the webservice sends the data to the AI model
When the webservice received an error response from the AI model
Then the webservice should send an error response to the python pre-processor

Scenario: valid response received from AI model for request with processed images data
Given the webservice receive a request with processed images from python pre-processor
And the webservice sends the data to the AI model
When the webservice received an acknowledgement response of successful receiving of data from the AI model
Then the webservice should send a success response to the python pre-processor

Scenario: invalid image data received in payload from python pre-processor request
Given the webservice receive a request with processed images from python pre-processor
When the webservice finds that the payload containing the request data is not in the expected format
Then the webservice should send an error response to the python pre-processor

Scenario: valid image data received in payload from python pre-processor request
Given the webservice receive a request with processed images from python pre-processor
And the request payload is in the expected format
And the webservice forwards it to the AI model
When the webservice received an acknowledgement response of successful receiving of data from the AI model
Then the webservice should send a success response to the python pre-processor

Scenario: invalid token in the request received from python pre-processor
Given the webservice receive a request with processed images from python pre-processor
When the token contained in the webservice is not valid
Then the webservice should send an error response back to the python pre-processor
