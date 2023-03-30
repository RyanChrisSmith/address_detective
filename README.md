<div align="center">

# *Address Detective*

<div style="max-width: 1000px; max-height: 5px;">
  <img src="images/detective-3.jpg" alt="your_image_alt_text" style="width: 100%; height: 100%">
</div>


### _Transform your command-line into a Sherlock Holmes of sorts, capable of solving the mystery of any US address! Build a program that harnesses the power of an API to validate the authenticity of a US address, revealing its true identity or boldly declaring it 'Invalid'. Get ready to don your detective cap and solve the case of the US Address!_

<u>

## Table of Contents
</u>

[Setup / Installation](#setup--installation)<br>
[Running the Program](#running-the-program)<br>
[Testing](#testing)<br>
[Reasoning and Decision Making](#reasoning-and-decision-making)<br>
[Gems and Environment](#gems-and-environment)<br>
[Usage](#usage)<br>
[Features](#features)<br>
[Testing](#testing)

<u>

## Setup / Installation
</u>
</div>

- This project assumes that you already have the necessary software installed on your machine to run a ruby program
  - Please note, any time you see `$` that is to signify the beginning of a terminal command, do not include the `$`
  - If not, you will need to look into installing a version manager such as `rbenv` to allow you to easily switch between `Ruby` versions [rbenv tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-macos)
  - Once a version manager is installed, install ruby using `$rbenv install 2.7.4`
  - You will need a bundler for the gems already in the file, run that by inputting `$gem install bundler`

  _Now you are ready to move forward with this repo!_

- Clone this Git repository to your local machine
- `$cd address_detective` into the repo on your machine
- Run `$bundle install` to add all the gems to your machine
- Well, well, well, it looks like we have a secret agent in our midst! There's an API Key involved that's so top-secret, it doesn't even come with the repo! Gotta keep those classified files under lock and key, am I right?
  - Go to `https://www.smarty.com/products/us-address-verification` to get an `API key` and `Authorization token`, you will need this and once your back I can direct you as to where they can go on your machine to stay safe and sound.
  - Create a file `$touch .env` which should create an empty `.env` file at the root level of the files
  - In that `.env` file add your keys as pictured below, but put your keys in the spaces that I have scratched out.
  <img src="images/screenshot.png">

  - Make sure to label the keys exactly the same as in the screenshot `SMARTY_AUTH_ID` and `SMARTY_AUTH_TOKEN` so that the keys will work properly when the program is run

<u>

## Running the Program
</u>

- Once you have finished the setup / installation, you are ready to run this beautiful program from your terminal
- Run `$ruby runner.rb data/test_addresses.csv`
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
- Steps that your arent seeing behind the scenes:
  - The program is reading from a static CSV file
  - Creating individual addresses out of each line
  - Sending that to a 3rd party API to verify the address
  - Receiving a response from the API of whether its valid or not
    - If it is valid it is giving you the official address with appropriate corrections
  - Then showing that response after the lamda or `->` of the corrected address or `Invalid Address`
<u>

## Reasoning and Decision Making
</u>


<u>

## Gems and Environment
</u>

_ENVIRONMENT_

This project used the ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) `VERSION 2.7.4` and was developed with ![Mac](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white) `VENTURA 13.2.1`

_GEMS_

[Bundler Audit](https://github.com/rubysec/bundler-audit) - used to scan a Ruby project's dependencies for known vulnerabilities and security issues

[DotEnv](https://github.com/bkeepers/dotenv) - loads environment variables from a .env file into the environment of a Ruby application, making it easy to manage sensitive configuration information such as API keys, passwords, and database credentials in a secure way without hardcoding them in the codebase.

[Pry](https://github.com/pry/pry) - provides a more powerful and interactive REPL (Read-Eval-Print Loop) console for debugging and exploring Ruby code.

[Rubocop](https://github.com/rubocop/rubocop) - provides a static code analyzer to enforce consistent coding style, best practices, and detect potential issues in a Ruby codebase.

[RSpec](https://github.com/rspec) - framework for writing and executing tests to ensure the expected behavior of a Ruby codebase.

[Simplecov](https://github.com/simplecov-ruby/simplecov) - provides code coverage analysis for a Ruby codebase.

[VCR](https://github.com/vcr/vcr) - provides a way to record and replay HTTP interactions between a Ruby application and an external API. This gem depends on WebMock (next gem) to intercept HTTP requests and responses, and provide the necessary stubbing and recording capabilities.

[WebMock](https://github.com/bblimke/webmock) - provides a way to stub HTTP requests and responses in Ruby tests
## Usage

Instructions for using the project, including examples.

## Features

A list of the project's features.

## Testing

Instructions for running tests, including any necessary setup.
