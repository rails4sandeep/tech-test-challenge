@electron_app
Feature: Electron App

Scenario: users with valid account
Given I am a user with a valid account
When I open the harrison electron app
Then I should be prompted to login
And I should be able to make requests after successful login with valid account details

Scenario: users with invalid account
Given I am a user with an invalid account
When I open the harrison electron app
Then I should be prompted to login
And I should be shown an error message asking to login again

Scenario: user forgot password
Given I am a user with an valid account
And I forgot my password
When I use the forgot password feature in the login page
Then I should receive link to reset my password
And I should be able to login successfully using new password through the login page

Scenario: Request results
Given I am a user with valid account
And I login to the electron app
When I request results providing all the mandatory inputs
Then I should receive the results from the platform

Scenario: Mandatory fields missing
Given I am a user with valid account
And I login to the electron app
When I request results without providing one or more of the mandatory inputs
Then I should see an error message requesting to fill the mandatory inputs

Scenario: request for results timeout
Given I am a user with valid account
And I login to the electron app
When I request results providing all the mandatory inputs
And the response does not arrive within the timeout period
Then I should receive an error message

Scenario: Electron app loses internet connection
Given I am a user with valid account
And my machine loses the internet connection
When I try to use the electron app
Then I should see the error message that the app is not usable

Scenario: Electron app loses and gains internet connection
Given I am a user with valid account
And I am logged into the electron app
And the machine loses internet connection
And I see an error message that the app is not usable
When the internet is back
Then I should see the message that the app is usable again

Scenario: response received critical
Given I am a user with valid account
And I am logged into the electron app
When I receive the response that the result is critical
Then the app UI should highlight the Lung Finding 2 page element
And the app UI should not highlight the Lung Finding 1 page element

Scenario: response received not critical
Given I am a user with valid account
And I am logged into the electron app
When I receive the response that the result is not critical
Then the app UI should highlight the Lung Finding 1 page element
And the app UI should not highlight the Lung Finding 2 page element

Scenario: invalid response received
Given I am a user with valid account
And I am logged into the electron app
When I receive the response that is not in the expected format
Then the app should display an error
And it should not hightlight either of the page elements Lung Finding 1 or Lung Finding 2

Scenario: image not found
  Given I am a user with valid account
  And I am logged into the electron app
  When I receive the response that refers to an image url that does not contain the image
  Then the app should display an error
  And it should not hightlight either of the page elements Lung Finding 1 or Lung Finding 2

Scenario: invalid finding id
  Given I am a user with valid account
  And I am logged into the electron app
  When I receive the response that has the image data refer to findingId that is neither 1 nor 2
  Then the app should display an error
  And it should not hightlight either of the page elements Lung Finding 1 or Lung Finding 2

Scenario: invalid value for critical
  Given I am a user with valid account
  And I am logged into the electron app
  When I receive the response that has the critical attribute in findings Array has a value that is neither true nor false
  Then the app should display an error
  And it should not hightlight either of the page elements Lung Finding 1 or Lung Finding 2




