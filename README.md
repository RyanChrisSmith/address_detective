<div align="center">

# *Address Detective*

### _Transform your command-line into a Sherlock Holmes of sorts, capable of solving the mystery of any US address! Build a program that harnesses the power of an API to validate the authenticity of a US address, revealing its true identity or boldly declaring it 'Invalid'. Get ready to don your detective cap and solve the case of the US Address!_

<u>

## Table of Contents
</u>

[Setup / Installation](#setup--installation)<br>
[Running the Program](#running-the-program)<br>
[Testing](#testing)<br>
[Reasoning and Decision Making](#reasoning-and-decision-making)<br>
[Gems](#gems)<br>
[Testing](#testing)

<u>

_ENVIRONMENT_
</u>
</div>

This project used the ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) `VERSION 3.1.2` and was developed/tested with ![Mac](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white) `VENTURA 13.2.1`

Be curious and click on the links for the many [pull requests](https://github.com/RyanChrisSmith/address_detective/pulls?q=is%3Apr+is%3Aclosed) with a *PR template* and an extensive [commit history](https://github.com/RyanChrisSmith/address_detective/commits/main) to keep track of all changes
<br>

<u>

## Setup / Installation
</u>

- Please note, any time `$` is in the command line prompt, that is to signify the beginning of a terminal command, do not include the `$` in the input
- To install the necessary software to run a ruby program, please follow the sub points below:
  - To install a version manager such as `rbenv` to easily switch between `Ruby` versions [rbenv tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-macos)
  - Once a version manager is installed, install ruby using `$ rbenv install 3.1.2`
  - To install a bundler for the gems already in the file, run that by inputting `$ gem install bundler`

  _Now you are ready to move forward with this repo!_

- Clone this Git repository to your local machine [here](https://github.com/RyanChrisSmith/address_detective)
- `$ cd address_detective` into the repo
- Run `$ bundle install` to add all the gems
- Well, well, well, it looks like we have a secret agent in our midst! There's an API Key involved that's so top-secret, it doesn't even come with the repo! Gotta keep those classified files under lock and key, am I right?
  - Go to `https://www.smarty.com/products/us-address-verification` to get an `API key` and `Authorization token`, you will need this and once back I can direct you as to where they can go on your machine to stay safe and sound.
  - Create a file `$ touch .env` which should create an empty `.env` file at the root level of the files
  - In that `.env` file add your keys as pictured below

  <img src="images/screenshot.png">

  - Make sure to label the keys exactly the same as in the screenshot `SMARTY_AUTH_ID` and `SMARTY_AUTH_TOKEN` so that the keys will work properly when the program is run
  - ONE LAST THING BEFORE YOU GO ANYWHERE! Make sure *YOUR* keys are protected too! Check in the `.gitignore` file to make sure it shows `.env` listed. If it is, you are safe, if not add it to the file.


  <img src="images/screenshot-2.png">

  - This way, the API keys will stay out of the commit history keeping them safe from prying eyes

  - If the preference is to see the documentation for all public methods' args and return types, there are some YARD documentation created to see just that. See explanation of gems used [below](#gems-why-these-ones) or go to the [yard gem page](https://github.com/lsegal/yard)
    - In the terminal, run `$ yard server` and then go to url `http://localhost:8808` in a browser window.
    - Feel free to click around on the different classes and see what each method in each class is doing
    - Once you are done looking around, either `Ctrl-C` to stop the server or open a new terminal window with `Ctrl-N` before going to the next step
### [Back to Table of Contents](#table-of-contents)

<u>

## Running the Program
</u>

- Once setup / installation is finished, it is time to run this beautiful program from your terminal
- Run `$ ruby runner.rb data/test_addresses.csv`
- The response you should see in the terminal will look like this:
```
143 e Maine Street, Columbus, 43215 -> 143 E Main St, Columbus, 43215-5370
1 Empora St, Title, 11111 -> Invalid Address
24 Second Avenue, San Mateo, 94401 -> 24 2nd Ave, San Mateo, 94401-3828
24 Second Avenue, San Mateo, 84405 -> Invalid Address
800 Middle Avenue, Menlo Park, 94025-9881 -> 800 Middle Ave, Menlo Park, 94025-5121
500 Arbor Road, Menlo Park, 94025 -> 500 Arbor Rd, Menlo Park, 94025-5132
123 N. Elm St, Springfield, 65802 -> Invalid Address
123 South Elm St, Springfield, 65802 -> Invalid Address
1 Main St, New York, 10001-1111 -> 1 Main St, New York, 10044-0052
1234 Random Rd, Smallville, 1234 -> Invalid Address
123 Long Street, City, ABCDE -> Invalid Address
1234 Second Street, Big City, 1234567 -> 1234 Second Street, Schenectady, 12345-0001
```
- Steps behind the scenes:
  - The program is reading from a static CSV file
  - Creating individual addresses out of each line
  - Sending that to a 3rd party API to verify the address
  - Receiving a response from the API of whether its valid or not
    - If it is valid it is giving you the official address with appropriate corrections
  - Then showing that response after the lamda or `->` with either the *corrected address* or `Invalid Address`

## ***EXTENSION***

  - *The API allows for bulk address looks ups beyond the single address method*
    - *This does require some adjustments on where information is passed in the API call, such as headers and in the body, so pay close attention to the difference in the way the code is written*
  - *This program will allow for that in the same command line you just did, but with a much larger file*
  - *Run `$ ruby runner_bulk.rb data/test_bulk_addresses.csv`*
  - *This allows for 100 addresses OR 32k worth of data to be requested in one call! Awesome!*
  - *The results will look quite similar to the single address look up from above, but the list will be much longer*
  - *Keep in mind this will use the same amount of API calls that it would if you went address by address, but was built for speed and convenience*
  ```
  143 E Maine St, Columbus, 43215 -> 143 E Main St, Columbus, 43215-5370
  1 Emporia St, Tallahassee, 32301 -> Invalid Address
  24 Second Ave, San Mateo, 94403 -> 24 2nd Ave, San Mateo, 94401-3828
  24 Second Ave, San Mateo, 94404 -> 24 2nd Ave, San Mateo, 94401-3828
  800 Middle Ave, Menlo Park, 94025 -> 800 Middle Ave, Menlo Park, 94025-5121
  500 Arbor Rd, Menlo Park, 94025 -> 500 Arbor Rd, Menlo Park, 94025-5132
  123 N Elm St, Springfield, 65802 -> Invalid Address
  123 S Elm St, Springfield, 65802 -> Invalid Address
  1 Main St, New York, 10001 -> 1 Main St, New York, 10044-0052
  1234 Random Rd, Smallville, 12345 -> 1234 Random Rd, Schenectady, 12345-0001
  123 Long St, Charleston, 29401 -> Invalid Address
  1234 Second St, Los Angeles, 90001 -> Invalid Address
  543 W Main St, Columbus, 43215 -> Invalid Address
  678 E High St, Springfield, 65802 -> Invalid Address
  910 S Main St, Akron, 44311 -> Invalid Address
  11 Elmwood Dr, San Francisco, 94132 -> Invalid Address
  1200 Lincoln Ave, San Rafael, 94901 -> Invalid Address
  55 State St, Boston, 02109 -> Invalid Address
  500 Boylston St, Boston, 02116 -> 500 Boylston St, Boston, 02116-3740
  1 Memorial Dr, Cambridge, 02142 -> 1 Memorial Dr, Cambridge, 02142-1313
  700 Technology Sq, Cambridge, 02139 -> 700 Technology Sq, Cambridge, 02139-3557
  15 Washington St, Cambridge, 02140 -> Invalid Address
  11 Waverly St, Boston, 02135 -> Invalid Address
  2 West St, Boston, 02111 -> 2 West St, Boston, 02111-1204
  123 Maple St, Portland, 04101 -> Invalid Address
  456 Pine St, Portland, 04102 -> Invalid Address
  789 Oak St, Portland, 04103 -> Invalid Address
  1122 Forest St, Portland, 04104 -> Invalid Address
  135 Elm St, Portland, 04105 -> Invalid Address
  158 Birch St, Portland, 04106 -> Invalid Address
  221 Walnut St, Portland, 04107 -> 221 Walnut St, South Portland, 04106-4733
  354 Chestnut St, Portland, 04108 -> Invalid Address
  487 Cedar St, Portland, 04109 -> Invalid Address
  510 Spruce St, Portland, 04110 -> Invalid Address
  633 Pine St, San Francisco, 94108 -> Invalid Address
  755 Cherry St, San Francisco, 94109 -> Invalid Address
  878 Mango St, San Francisco, 94110 -> Invalid Address
  991 Banana St, San Francisco, 94111 -> Invalid Address
  112 Avocado St, San Francisco, 94112 -> Invalid Address
  235 Orange St, San Francisco, 94113 -> Invalid Address
  358 Lemon St, San Francisco, 94114 -> Invalid Address
  481 Grape St, San Francisco, 94115 -> Invalid Address
  504 Watermelon St, San Francisco, 94116 -> Invalid Address
  627 Peach St, San Francisco, 94117 -> Invalid Address
  750 Plum St, San Francisco, 94118 -> Invalid Address
  873 Papaya St, San Francisco, 94119 -> Invalid Address
  996 Kiwi St, San Francisco, 94120 -> Invalid Address
  113 Walnut St, San Diego, 92101 -> Invalid Address
  246 Maple St, San Diego, 92102 -> Invalid Address
  379 Pine St, San Diego, 92103 -> Invalid Address
  412 Oak St, San Diego, 92104 -> Invalid Address
  535 Chestnut St, San Diego, 92105 -> Invalid Address
  658 Cedar St, San Diego, 92106 -> Invalid Address
  781 Spruce St, San Diego, 92107 -> Invalid Address
  814 Pineapple St, San Diego, 92108 -> Invalid Address
  937 Cherry St, San Diego, 92109 -> Invalid Address
  1060 Mango St, San Diego, 92110 -> Invalid Address
  1183 Banana St, San Diego, 92111 -> Invalid Address
  1306 Avocado St, San Diego, 92112 -> Invalid Address
  143 Walnut St, San Jose, 95110 -> Invalid Address
  276 Maple St, San Jose, 95111 -> Invalid Address
  409 Pine St, San Jose, 95112 -> Invalid Address
  532 Oak St, San Jose, 95113 -> Invalid Address
  655 Chestnut St, San Jose, 95114 -> Invalid Address
  778 Cedar St, San Jose, 95115 -> Invalid Address
  221 Walnut St, Portland, 04107 -> 221 Walnut St, South Portland, 04106-4733
  354 Chestnut St, Portland, 04108 -> Invalid Address
  487 Cedar St, Portland, 04109 -> Invalid Address
  510 Spruce St, Portland, 04110 -> Invalid Address
  358 Lemon St, San Francisco, 94114 -> Invalid Address
  481 Grape St, San Francisco, 94115 -> Invalid Address
  504 Watermelon St, San Francisco, 94116 -> Invalid Address
  627 Peach St, San Francisco, 94117 -> Invalid Address
  750 Plum St, San Francisco, 94118 -> Invalid Address
  873 Papaya St, San Francisco, 94119 -> Invalid Address
  996 Kiwi St, San Francisco, 94120 -> Invalid Address
  113 Walnut St, San Diego, 92101 -> Invalid Address
  246 Maple St, San Diego, 92102 -> Invalid Address
  379 Pine St, San Diego, 92103 -> Invalid Address
  1234 Random Rd, Smallville, 12345 -> 1234 Random Rd, Schenectady, 12345-0001
  123 Long St, Charleston, 29401 -> Invalid Address
  1234 Second St, Los Angeles, 90001 -> Invalid Address
  543 W Main St, Columbus, 43215 -> Invalid Address
  678 E High St, Springfield, 65802 -> Invalid Address
  910 S Main St, Akron, 44311 -> Invalid Address
  11 Elmwood Dr, San Francisco, 94132 -> Invalid Address
  678 E High St, Springfield, 65802 -> Invalid Address
  910 S Main St, Akron, 44311 -> Invalid Address
  11 Elmwood Dr, San Francisco, 94132 -> Invalid Address
  1200 Lincoln Ave, San Rafael, 94901 -> Invalid Address
  55 State St, Boston, 02109 -> Invalid Address
  500 Boylston St, Boston, 02116 -> 500 Boylston St, Boston, 02116-3740
  1 Memorial Dr, Cambridge, 02142 -> 1 Memorial Dr, Cambridge, 02142-1313
  700 Technology Sq, Cambridge, 02139 -> 700 Technology Sq, Cambridge, 02139-3557
  15 Washington St, Cambridge, 02140 -> Invalid Address
  11 Waverly St, Boston, 02135 -> Invalid Address
  2 West St, Boston, 02111 -> 2 West St, Boston, 02111-1204
  123 Maple St, Portland, 04101 -> Invalid Address
  456 Pine St, Portland, 04102 -> Invalid Address
  ```



### [Back to Table of Contents](#table-of-contents)

<u>

## Reasoning and Decision Making
</u>

This program is an example of how to use various programming concepts, libraries, and APIs to build a tool that validates and corrects addresses using the SmartyStreets API.

At a high level, the program reads in a CSV file containing addresses, creates CsvAddress objects to represent each address, validates and corrects each address using the SmartyStreetsApi API, and outputs the corrected address via the ResponseConverter in the console.

The code provided includes five classes, each with its own responsibility. Here is an overview of each class alphabetically and its design decisions:

- ApiAddress class - This class represents an address returned from a third-party API. It has five attributes: street, city, zip, plus4_code, and index. The street, city, zip, and plus4_code are required attributes, and the index is an optional attribute. The class has an initializer that accepts the required attributes as arguments and sets them as instance variables. The initializer also sets the index attribute to nil if it is not provided. The validated method returns the full address as a string in the format "street, city, zip-code plus4-code". The design decision here is to have a separate class to represent an address returned from the API. This class encapsulates the data returned from the API and provides a way to access and validate that data.

- CsvAddress class - This class represents an address in a CSV file. It has three attributes: street, city, and zip_code. The street, city, and zip_code are required attributes, and the class has an initializer that accepts these attributes as arguments. The initializer validates that the arguments are not empty or nil, sets them as instance variables after stripping whitespace, and raises an ArgumentError if any of them are blank. The complete method returns the full address as a string in the format "street, city, zip_code". The design decision here is to have a separate class to represent an address in a CSV file. This class encapsulates the data from the CSV file and provides a way to validate and format the data.

- CsvReader class - This class reads addresses from a CSV file and returns an array of CsvAddress objects. The class uses the CSV library to read the file and the CsvAddress class to create objects for each row in the file. The CSV.foreach method is used to iterate over the rows in the file and convert each row into a CsvAddress object using the CsvAddress.new method. The design decision here is to have a separate class to read CSV files and create CsvAddress objects. This class encapsulates the logic of reading the file and creating objects.

- ResponseConverter class - This class converts response data from the SmartyStreets API into ApiAddress objects. The class has two methods: single and bulk. The single method takes a single address from the API response and creates an ApiAddress object from the data. The bulk method takes a list of addresses from the API response and creates a list of ApiAddress objects. Both methods extract the necessary data from the response and pass it to the ApiAddress.new method to create the objects. The design decision here is to have a separate class to convert the API response data into ApiAddress objects. This class encapsulates the logic of extracting the necessary data and creating objects.

- SmartyStreetsApi class - This class makes requests to the SmartyStreets API, which is used to confirm the validity of addresses. This class provides a convenient way to interact with the SmartyStreets API and confirm the validity of addresses. It has two public class methods and one private class method.
  - The first public class method confirm_address takes three arguments street, city, and zip_code, representing the address to be confirmed, and makes a GET request to the SmartyStreets API to confirm its validity. It returns a hash containing the response from the API.

  - The second public class method bulk_addresses takes an array of hashes as an argument, where each hash represents an address containing the keys :street, :city, and :zip_code. It then makes a POST request to the SmartyStreets API to confirm the validity of all the addresses in bulk. It returns a hash containing the response from the API.

  - The private class method conn sets up a connection to the SmartyStreets API using the Faraday gem. It returns a Faraday connection object with the base URL, authentication credentials, and candidate limit set. This method is used by the two public methods to make requests to the API.

Overall, this program demonstrates how to use OOP principles, libraries, and APIs to build a tool that solves a specific problem: validating and correcting addresses. By following the Single Responsibility Principle, the program is easier to understand, easier to maintain, and easier to modify. Plus, it helps to avoid the dreaded "spaghetti code" - code that's so intertwined and convoluted that it's hard to tell what's going on.
### [Back to Table of Contents](#table-of-contents)

<u>

## Gems (Why these ones?)
</u>

[Bundler Audit](https://github.com/rubysec/bundler-audit) - used to scan a Ruby project's dependencies for known vulnerabilities and security issues

[DotEnv](https://github.com/bkeepers/dotenv) - loads environment variables from a .env file into the environment of a Ruby application, making it easy to manage sensitive configuration information such as API keys, passwords, and database credentials in a secure way without hardcoding them in the codebase.

[Pry](https://github.com/pry/pry) - provides a more powerful and interactive REPL (Read-Eval-Print Loop) console for debugging and exploring Ruby code.

[Rubocop](https://github.com/rubocop/rubocop) - provides a static code analyzer to enforce consistent coding style, best practices, and detect potential issues in a Ruby codebase.

[RSpec](https://github.com/rspec) - framework for writing and executing tests to ensure the expected behavior of a Ruby codebase.

[Simplecov](https://github.com/simplecov-ruby/simplecov) - provides code coverage analysis for a Ruby codebase.

[VCR](https://github.com/vcr/vcr) - provides a way to record and replay HTTP interactions between a Ruby application and an external API. This gem depends on WebMock (next gem) to intercept HTTP requests and responses, and provide the necessary stubbing and recording capabilities.

[WebMock](https://github.com/bblimke/webmock) - provides a way to stub HTTP requests and responses in Ruby tests

[Yard](https://github.com/lsegal/yard) - documentation generation tool for Ruby code that simplifies the process of creating high-quality API documentation.

### [Back to Table of Contents](#table-of-contents)

<u>

## Testing
</u>

- _If you would like to run the test suite_
  - Run `$ bundle exec rspec` to execute the whole test suite
  - You will notice beyond the passing tests that `simplecov` is generating a Coverage Report. This helps to identify any code that was written is actually being tested. You can `$ open coverage/index.html` to see a visual representation of what is being covered.

- _If you would like to check the code for any known vulnerabilities_
  - Run `$ bundle audit check --update`
  - Using the update flag makes sure that the gem is checking with the most recently known advisories and vulnerabilities

- _There should be a fixtures folder within the spec folder_
  - After running `bundle exec rspec` you may have noticed a new folder pop up under the `spec` folder
  - That is there courtesy of the VCR gem
  - These are the recordings of the original API call that are then used in the subsequent times running the tests. This way, the actual API calls are limited after the test has been run the first time.
  - There is a cassette tape for every test that has `:vcr` in its `it` block description
  - The API key and token that are used in the call are hidden, but to be doubly sure this file is also can also be added to the `.gitignore` so it isn't public
    - The configuration for the VCR cassette tapes is in the `spec_helper` file at the bottom if you are curious

- See below for a more specified explanation of each test file for each class

The code is a set of RSpec tests to test classes CsvAddress, CsvReader, and ResponseAddress for validating and processing addresses.

- _The ApiAddress class_ is tested to ensure that it can be initialized with valid attributes (street, city, zip, plus4_code, index), set the correct attribute values, and return a validated address string. It is also tested to set the index attribute to nil if it is not provided during initialization.

- _The CsvAddress class_ is tested to ensure that it is initialized with valid attributes (street, city, zip_code) and will create an object for each address from a CSV file, even if it has incomplete or whitespace values. It is also tested to return the complete address as a string and to raise an ArgumentError if any attributes are empty.

- _The CsvReader class_ is tested to ensure that it can retrieve all addresses from a test CSV file and return them as CsvAddress objects with the correct values for each attribute.

- _The ResponseConverter class_ is tested to make sure it converts response data from the SmartyStreets API into a standardized format. The program contains a single test for the '.bulk' method in the 'ResponseConverter' class. The test includes sample data for three address candidates with various data points such as delivery line, last line, components, metadata, and analysis. The test case validates that the method can properly parse and format the given data.

- _The SmartyStreetsApi_ tests contains two main blocks: "happy path" and "sad path". The "happy path" block tests that the SmartyStreetsApi.confirm_address method returns the expected result when given valid input. It also uses VCR to record and replay the HTTP request/response interaction with the SmartyStreets API, so that the tests can be run repeatedly without hitting the API every time. The "sad path" block contains several test cases that simulate various error scenarios that can occur when using the SmartyStreetsApi.confirm_address method. These include testing for connection errors, timeout errors, invalid JSON responses, and various HTTP error responses, such as 401 Unauthorized, 402 Payment Required, and 500 Server Error. The tests use RSpec's expect and raise_error matchers to verify that the correct error is raised under each scenario.

### [Back to Table of Contents](#table-of-contents)

<u>

## Extension Ideas
</u>

- Wrap error handling for third party API responses to future proof for versions 2 and beyond
- Implementing a background worker for the async API calls before the software is handling large data sets
- Write a CSV file for output rather than just in command line
- Handling other file types for initial input (pdf, json, yaml, xml)
- Error handling for input file issues (wrong headers, no commas, too many commas, weird encoding, strange characters, extra comma(s) in street attribute)

