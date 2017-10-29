require 'rubygems'
require 'bundler'
require 'tty-prompt'
require 'require_all'

Bundler.setup(:default)

require_rel 'lib/command_loader'
require_rel 'lib/zen_search'

prompter = TTY::Prompt.new
commands_dir = File.join(File.dirname(__FILE__), 'lib', 'commands')
command_loader = CommandLoader.new(commands_dir)
zen_search = ZenSearch.new(prompter, command_loader)
zen_search.run
