require 'spec_helper'

describe SearchEngine do

  describe '.search' do
    let(:data_store) { DataStore.new }
    let(:alias_value) { 'Buddha' }
    let(:likes_bananas) { true }
    let(:tag1) { 'tag1' }
    let(:tag2) { 'tag2' }
    let(:tag3) { 'tag3' }
    let(:entry1) do
      {
        "_id" => 1,
        "alias" => alias_value,
        "likes_bananas" => likes_bananas,
        "tags" => [ tag1, tag2, tag3 ]
      }
    end
    let(:entry2) do
      {
        "_id" => 2,
        "alias" => 'Some other alias',
        "likes_bananas" => !likes_bananas,
        "tags" => []
      }
    end
    let(:search_data) { [ entry1, entry2 ] }

    subject { described_class.search(data_store, search_key, search_value) }

    before do
      data_store.store('test', search_data)
    end

    context 'json value is a string' do
      let(:search_key) { 'alias' }
      let(:search_value) { alias_value }

      context 'full match' do
        let(:expected_value) { [ entry1 ] }
        it { is_expected.to eq expected_value }
      end
    end

    context 'json value is an integer' do
      let(:search_key) { '_id' }
      let(:search_value) { '1' }

      context 'full match' do
        let(:expected_value) { [ entry1 ] }
        it { is_expected.to eq expected_value }
      end
    end

    context 'json value is a boolean' do
      let(:search_key) { 'likes_bananas' }
      let(:search_value) { likes_bananas.to_s }

      context 'full match' do
        let(:expected_value) { [ entry1 ] }
        it { is_expected.to eq expected_value }
      end
    end

    context 'json value is an array' do
      let(:search_key) { 'tags' }
      let(:search_value) { tag3 }

      context 'full match' do
        let(:expected_value) { [ entry1 ] }
        it { is_expected.to eq expected_value }
      end
    end
  end

end