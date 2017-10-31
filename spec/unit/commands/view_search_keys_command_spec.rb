require 'spec_helper'

require_rel '../../../lib/commands'

describe Commands::ViewSearchKeysCommand do
  let(:command) { described_class.new }

  describe '#execute' do
    let(:prompter) { double }
    let(:outputter) { double }
    let(:data_store) { double }

    subject { command.execute(prompter, outputter, data_store) }

    context 'no data has been loaded' do
      let(:no_data_loaded_message) { "Please load a file before executing this command.\n\n" }
      let(:file_types) { [] }

      before do
        allow(outputter).to receive(:puts)
        allow(data_store).to receive(:file_types) { file_types }
        subject
      end

      it 'prints the no data loaded message' do
        expect(outputter).to have_received(:puts).with(no_data_loaded_message)
      end
    end

    context 'data has been loaded' do
      let(:file_types) { %w(users tickets) }
      let(:selected_file_type) { file_types.first }
      let(:file_type_keys) { %w(key1 key2) }
      let(:keys_message) do
        "Keys for #{selected_file_type}:\n#{file_type_keys.join("\n")}\n\n"
      end

      before do
        allow(outputter).to receive(:puts)
        allow(data_store).to receive(:file_types) { file_types }
        allow(prompter).to receive(:select).with('Which file type would you like to see keys for?', file_types) { selected_file_type }
        allow(data_store).to receive(:keys_for).with(selected_file_type) { file_type_keys }
        subject
      end

      it 'prints the keys for the given file type' do
        expect(outputter).to have_received(:puts).with(keys_message)
      end
    end
  end

end
