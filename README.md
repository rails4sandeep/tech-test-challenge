## Technical Test Exercise

#### Test Strategy
[Test Strategy](TestStrategy.md) 

#### Tests
Sample tests are written as Cucumber features and scenarios using Gherkin syntax

* [Electron App scenarios](features/electron_app.feature)
* [Webservices scenarios](features/webservices.feature)
* [Python preprocessor scenarios](features/python_preprocessor.feature)
* [AI Model scenarios](features/ai_model.feature)

#### Sample UI Tests
* I also wrote some sample UI tests using some pseudo elements and urls. 
* I used Javascript and Webdriverio to write the tests. Jest as the test runner.
* Wrote a small page object pattern framework. 
* An object representing the electron app. 
* A `Page` class.
* A `Browser` class 

The test can be found at
* [Sample UI Tests](test/electron-app.test.js)
