require 'spec_helper'

describe CommandLoader do
  let(:commands_path) { File.join(File.dirname(__FILE__), 'test_files', 'command_loader', 'valid') }
  let(:command_loader) { described_class.new(commands_path) }

  describe '#load' do
    subject { command_loader.load! }

    context 'valid path' do
      it 'loads one command' do
        expect(subject.length).to eq 1
      end

      it 'has a class of TestCommand' do
        expect(subject.first.class).to eq Commands::TestCommand
      end
    end

    context 'file name / class name mismatch' do
      let(:commands_path) { File.join(File.dirname(__FILE__), 'test_files', 'command_loader', 'classname_mismatch') }

      before do
        hide_const('Commands::TestCommand') if defined? Commands::TestCommand
      end

      it 'raises a InvalidCommandError' do
        expect { subject }.to raise_error(InvalidCommandError)
      end
    end

    context 'irrelevant files in the commands directory' do
      let(:commands_path) { File.join(File.dirname(__FILE__), 'test_files', 'command_loader', 'irrelevant_files') }

      it 'no commands are loaded' do
        expect(subject).to be_empty
      end
    end
  end
end
