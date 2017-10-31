require 'spec_helper'

describe DataStore do
  let(:data_store) { described_class.new }

  describe '#select' do
    let(:test_data) do
      [
        {
          '_id' => 1,
          'alias' => 'An alias',
          'likes_bananas' => true,
          'tags' => %w(tag1 tag2 tag3)
        }
      ]
    end

    subject do
      data_store.select { condition_met }
    end

    context 'no data loaded' do
      it { is_expected.to eq [] }
    end

    context 'data loaded, but does not meet conditions' do
      let(:condition_met) { false }

      before { data_store.store('test', test_data) }

      it { is_expected.to eq [] }
    end

    context 'data loaded, and meets conditions' do
      let(:condition_met) { true }

      before { data_store.store('test', test_data) }

      it { is_expected.to eq test_data }
    end

    describe 'data loaded from multiple sources' do
      let(:other_test_data) do
        [
          {
            '_id' => 33,
            'alias' => 'Some other alias',
            'likes_bananas' => true,
            'tags' => %w(tag1 tag2 tag3)
          }
        ]
      end
      let(:condition_met) { true }
      let(:merged_test_data) do
        [
          test_data,
          other_test_data
        ].flatten
      end

      before do
        data_store.store('test', test_data)
        data_store.store('test2', other_test_data)
      end

      it { is_expected.to eq merged_test_data }
    end
  end

  describe '#keys_for' do
    let(:file_type) { 'users' }

    subject { data_store.keys_for(file_type) }

    context 'file type has not been stored' do
      it 'raises an argument error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'file type has been stored, but has no data' do
      before { data_store.store(file_type, []) }

      it { is_expected.to eq [] }
    end

    context 'file type has been stored and has single entry' do
      let(:entry) { { a: 1, b: 2, c: 3 } }
      let(:data) { [ entry ] }
      let(:keys) { entry.keys.map(&:to_s) }

      before { data_store.store(file_type, data) }

      it { is_expected.to eq keys }
    end

    context 'file type has been stored and has multiple entries' do
      let(:entry1) { { b: 1, a: 2, c: 3 } }
      let(:entry2) { { b: 1, a: 2, d: 3 } }
      let(:data) { [ entry1, entry2 ] }
      let(:keys) do
        entry1_keys = entry1.keys.map(&:to_s)
        entry2_keys = entry2.keys.map(&:to_s)
        [ entry1_keys, entry2_keys ].flatten.uniq
      end

      before { data_store.store(file_type, data) }

      it { is_expected.to match_array keys }

      it 'sorts keys' do
        expect(subject).to eq keys.sort
      end
    end
  end

end
