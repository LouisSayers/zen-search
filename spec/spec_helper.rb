require 'rubygems'
require 'bundler'
require 'tty-prompt'
require 'byebug'
require 'require_all'
require 'json'

Bundler.setup(:default, :development, :test)

require_rel '../lib/errors'
require_rel '../lib/command_loader'
require_rel '../lib/data_store'
require_rel '../lib/search_engine'
require_rel '../lib/zen_search'
