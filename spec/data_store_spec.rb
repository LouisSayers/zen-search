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

end
