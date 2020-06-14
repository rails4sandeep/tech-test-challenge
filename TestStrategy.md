## Test Strategy

The architecture diagram and details sent in the email are the references for this exercise. 
I noticed a missing arrow representing the Webservice requesting data from the DB. There is an arrow present that 
represents the DB sending data to the Webservices. 

For this test strategy, I am assuming that the Webservices process the request data received from the electron app, 
send a request to the DB and DB sends back the requested information. 

### Platform Architecture

From my understanding of the test example, platform architecture involves

1. An AI modelling backend service that reads processed images sent to it, trains and stores the processed data in DB
2. A database to store the images and model data
3. A Webservice to process requests and serve responses
4. An external system PACS that provides raw data for training of the AI
5. A python program that processes raw image data and feeds to the AI model backend service through the Webservice
6. An electron based desktop app that sends a request for analysis and receives processed results from the AI model

### Assumptions

There are a few assumptions made when writing the test strategy.
1. The individual components of the platform are designed keeping testability in view
2. The web services are designed to handle input sanitization, authentication, exception handling and proper error cascading
3. The AI model is configured to send through notifications about the result of the modelling of data
4. We have snapshots of acceptable trained data that we can use as a reference for testing of the AI model and its predictions
5. The python based pre-processor has a mechanism to handle and notify successful and unsuccessful processing of the images
6. The python pre-processor has a pre-defined standard for acceptable raw images. This is to ensure the quality of the AI model data and predictions

### Features of the platform

1. The training of the AI model
2. Web Services
3. Desktop App
4. Processing of raw image data into processed image data
5. Authentication and security

#### Types of testing to be utilized

**Specification-based dynamic test techniques:** Through specification-based testing, we use any requirements available and dynamic test approaches to test the platform. The specification-based approach ensures that the platform is robust, protected from potential corruption of data and opens ways for exploring the product using other test techniques.

* Input sanitization and validation
* Boundary value analysis
* Equivalence partitioning
* Exception Handling
* Decision Tables
* Use Cases

The targets for the specification-based testing are

* Web Services
* Desktop App
* Python Preprocessor
* AI Model

**Context-based testing:** Through context-based testing, as the platform changes through the release cycles, we monitor if the product and platform continue to achieve the original goal of the product. Considering the main feature of the platform is the predictions given by the AI model and assuming we have reference data for acceptable trained model data, we would be testing the AI model from two contexts

1. Load the model with a fresh set of data to be processed, process the data and compare the result with the reference data. Measure the quality. Reset the sample data.
2. Load the model with previously processed test data, add a fresh set of data, process the data and measure the result from maturity and prediction point of view. Save the processed data. Do not Reset.

**Exploratory Testing:** Through exploratory testing, we would invite a sample of our potential users, users with various levels of understanding of the platform and domain for user acceptance testing. We would time-bound the exploratory testing to a maximum of 60 minutes. They make notes, as they understand the product and explore it further. On completion of the cycle, the notes are shared, reviewed and recorded. During exploratory testing, the platform is used as a whole instead of individual components. In our scenario, the users will probably use the electron-based app during the exploratory testing (I do not see any other UI based components from the platform architecture diagram shared)

**Cross Platform Testing:** The electron app should be tested on the potential combination of operating systems and devices. If there is a list of supported devices and operating systems, it can be utilized for this.

**Load Testing:** The platform can be load tested at the web services layer. This load testing can be 
* Capacity planning measuring the load, the platform can handle with current capacity and planning for future
* Response time measurements - the time it takes for the requests to receive responses under various load conditions

**Risk-based testing:** Risk-based testing is an approach to testing where we list down the risks associated with the platform. The risks are sorted
in the order of severity. The severity of the risk is assigned based on the chance of risk happening and the impact it creates when it happens. The risk-based test coverage list provides us with a framework to refer to when we have to make critical decisions under severe deadlines, bring the product to market to compete with similar products, demand from the clients. 

#### Automated vs manual testing

All the specification and dynamic test technique based tests are targets for automated testing. Assuming the components mentioned as targets for this are designed from testability point of view, automating as much testing as possible will provide us with a way to continuously test, gather metrics, monitor quality and release frequently. 

* Web Services: Automated tests for user authentication, validation of data, acceptable ranges of data, handling of exceptions, error scenarios, use cases that are automatable and repeatable. The automated tests at API level are robust, fast and reliable compared to testing at the UI level. Because of the quick feedback they give compared to UI based tests, these tests can be configured to be run on demand on CI/CD for automatic approval and declining of merges
* Electron App: Automated UI tests to test the electron app. Authentication, use cases involving users uploading images, making requests for results, receiving results, usability, display of data in various screen resolutions. These tests can usually be run nightly on CI/CD
* Python Preprocessor: Automated testing of validation of the raw data, acceptable data and validation of processed data
* AI Model: Automated testing of validation of the input data

The testing of the AI model, context-based testing and exploratory testing will be manual. Any use cases that need manual intervention or that needs a lot of prerequisites to reach the state of testing are targets for manual testing.

#### Automated testing tools

It would be ideal to write the test automation using the tools and libraries available in the same technology stack used for the platform. 

If given a choice, Javascript would be a great option for the test automation of web services and frontend UI. 

Assuming web services are implemented as Restful APIs, Javascript/Nodejs has great libraries to test them like Cucumberjs (BDD style), Mocha, Jest. Supertest is a great Http library to process the requests and responses. Chai can be used to write readable English language like assertions.

Webdriverio is a great choice for writing UI tests. From my experience, it supports testing using a wide range of libraries and tools including browser drivers, mobiles, desktop. It enables us to write tests for electron-based apps as well. We can use it as a wholesome test automation framework with its inbuilt support for cucumber, mocha and jasmine or we can just use the webdriverio and build our framework. It is in existence for a few years now. It is well documented and has a good user base.

Another advantage of using webdriverio for UI automation is we can extend it if the company would like to support additional devices and browsers in future.

It is difficult to comment on the tools to use for automated testing of the pre-processor and the AI model, without insight into how the input and outputs are processed. If they are implemented as Restful microservices, we can use the same tools used for testing the Webservices.

#### Metrics to be monitored

* Testability
* Feature coverage of the automated tests
* Code coverage of the automated tests
* Defect leakage into production
* Success percentage of the UI test runs
* Success percentage of the non UI test runs
* Number of defects stopped from leaking into production per release 
* Risk coverage in test automation
* Outstanding risks based on test coverage
* Defects in the backlog
* Testing phase the defect is identified (the earlier the better)

#### What challenges do you expect and how you would deal with it?

**Typical challenges and tackling them:**
* Individual components are not designed with testability in view. In that case, it gets difficult to test individual components separately. This forces the testers to use integration testing through the UI resulting in long test cycles and flaky automated tests. - *Work with the Engineering team and product to improve the testability. This is easier said than done. We have to explore other ways of handling this challenge as well. Working with engineering to improve unit test coverage. Spending more times and resources in testing through UI*
* The platform uses a microservices architecture without a proper design and approach to consuming of the services. - *A short term solution would be to try to mock the dependencies. A long term solution is to do move towards a well-designed pattern.*
* The UI elements do not have a strategy to be accessible easily by the automated test tool - *Work with the front end developers to add test automation related attributes to the page elements* 
* Poor exception handling at the API level. Exceptions occurring are not propagated properly to the front end. The user is left wondering with no feedback, either success or failure. - *Write extensive exception scenarios in the API tests, work with the engineering team to handle them*
* Poor documentation of the API leading to spending lot of time to research the APIs, requests and responses. - *Work with the engineering team to improve the API documentation*


