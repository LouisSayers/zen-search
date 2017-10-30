require 'rubygems'
require 'bundler'
require 'tty-prompt'
require 'require_all'
require 'byebug'

Bundler.setup(:default, :test)

require_rel '../../lib/command_loader'
require_rel '../../lib/data_store'
require_rel '../../lib/search_engine'
require_rel '../../lib/zen_search'