# Zen Search

## Overview
This application allows you to search .json files for information.

You can search for data where a field has a given value. Empty values are able to be searched for. 

## User Requirements
* Allows for any field in a json document to be searched
* Handles large amounts of data (at least in the tens of thousands of data entries)

## Usage
Note:
_This project assumes the use of Ruby Version Manager (rvm) for managing ruby and gem dependencies (see [https://rvm.io/](https://rvm.io/) for installation details). ZenSearch was built and tested with Ruby 2.4.2_
 
* Ensure bundler is installed `gem install bundler -v 1.16.0.pre.3`
* Install gem dependencies `bundle install`
* Run the application `ruby zen_search.rb`
 
## Limitations
* The order of commands as presented in the terminal is based on the file name of the command
* When loading JSON files, the file paths must be relative to the project directory (absolute paths are not supported)
* Only full search is supported
* Search is currently case sensitive
