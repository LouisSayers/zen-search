require 'rubygems'
require 'bundler'
require 'tty-prompt'
require 'require_all'
require 'json'

Bundler.setup(:default, :development)

require_rel 'lib/errors'
require_rel 'lib/command_loader'
require_rel 'lib/data_store'
require_rel 'lib/search_engine'
require_rel 'lib/zen_search'

prompter = TTY::Prompt.new
commands_dir = File.join(File.dirname(__FILE__), 'lib', 'commands')
commands = CommandLoader.new(commands_dir).load!
data_store = DataStore.new

zen_search = ZenSearch.new(prompter, $stdout, commands, data_store)
zen_search.run
