require 'spec_helper'

require_rel '../../../lib/commands'

describe Commands::SearchCommand do
  let(:command) { described_class.new }

  describe '#execute' do
    let(:prompter) { double }
    let(:outputter) { double }
    let(:data_store) { double }

    subject { command.execute(prompter, outputter, data_store) }

    before do
      allow(outputter).to receive(:puts)
      allow(prompter).to receive(:ask)
      allow(SearchEngine).to receive(:search)
    end

    context 'valid search input' do
      let(:search_key) { 'SearchKey' }
      let(:search_value) { 'a search value' }
      let(:search_results) { %w(result1 result2) }

      before do
        allow(prompter).to receive(:ask).with('What type of data are you searching for?', convert: :string) { search_key }
        allow(prompter).to receive(:ask).with('What value are you searching for?', convert: :string) { search_value }
        allow(SearchEngine).to receive(:search).with(data_store, search_key, search_value) { search_results }
        subject
      end

      it 'performs the search' do
        expect(SearchEngine).to have_received(:search).with(data_store, search_key, search_value)
      end

      it 'prints the output from the search' do
        expect(outputter).to have_received(:puts).with(search_results)
      end
    end

    context 'empty type given' do
      let(:search_key) { nil }
      let(:expected_invalid_type_message) { 'You must give a type of key to search for' }

      before do
        allow(prompter).to receive(:ask).with('What type of data are you searching for?', convert: :string) { search_key }
        subject
      end

      it 'does not perform a search' do
        expect(SearchEngine).not_to have_received(:search)
      end

      it 'informs the user that the json file is invalid' do
        expect(outputter).to have_received(:puts).with(expected_invalid_type_message)
      end
    end
  end

end
