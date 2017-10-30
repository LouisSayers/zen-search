require 'spec_helper'
require_rel '../../../lib/commands'

describe Commands::LoadJsonDataCommand do
  let(:command) { described_class.new }

  describe '#execute' do
    let(:prompter) { double }
    let(:outputter) { double }
    let(:data_store) { double }

    subject { command.execute(prompter, outputter, data_store) }

    shared_examples 'invalid path' do |pathname|
      let(:expected_invalid_path_message) { 'It seems that there is no file at that location...' }

      before do
        allow(outputter).to receive(:puts)
        allow(prompter).to receive(:ask).with('Please enter the path of the file', convert: :path) { pathname }
      end

      it 'does not raise an error' do
        expect { subject }.not_to raise_error
      end

      it 'informs the user that the json file is invalid' do
        subject
        expect(outputter).to have_received(:puts).with(expected_invalid_path_message)
      end
    end

    context 'empty string given as the path' do
      include_examples 'invalid path', nil
    end

    context 'path to json file does not exist' do
      include_examples 'invalid path', Pathname.new('/path/to/nowhere.json')
    end
  end

end