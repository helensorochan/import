require 'rails_helper'

RSpec.describe Import::Parser do

  subject(:parser) { described_class.new(file_path) }

  describe '#status' do
    context 'when parser run without file' do
      let(:file_path){ nil }

      it 'should equal interrupted' do
        parser.run
        expect(parser.status).to eq(:interrupted)
      end
    end

    context 'when parser run with wrong format' do
      let(:file_path){ 'spec/fixtures/test.txt' }

      it 'should equal finished' do
        parser.run
        expect(parser.status).to eq(:finished)
      end
    end

    context 'when parser run with empty file' do
      let(:file_path){ 'spec/fixtures/empty_file.csv' }

      it 'should equal data missing' do
        parser.run
        expect(parser.status).to eq(:finished)
      end
    end

    context 'when parser run with records' do
      let(:file_path){ 'spec/fixtures/valid_records.csv' }

      it 'should equal finished' do
        parser.run
        expect(parser.status).to eq(:finished)
      end
    end
  end

  describe '#records' do
    context 'when parser run without file' do
      let(:file_path){ nil }

      it 'should equal interrupted' do
        parser.run
        expect(parser.records).to be_nil
      end
    end

    context 'when parser run with wrong format' do
      let(:file_path){ 'spec/fixtures/test.txt' }

      it 'should equal finished' do
        parser.run
        expect(parser.records).to be_blank
      end
    end

    context 'when parser run with empty file' do
      let(:file_path){ 'spec/fixtures/empty_file.csv' }

      it 'should equal data missing' do
        parser.run
        expect(parser.records).to be_blank
      end
    end

    context 'when parser run with records' do
      let(:file_path){ 'spec/fixtures/valid_records.csv' }

      it 'should equal finished' do
        parser.run
        expected_result = [%w(sku title field1 field2 field3 field4 count price),
                           ["p1", "title1", "f11", "f12", "f13", "f14", "1", "34.67"]]

        expect(parser.records.to_a).to eq(expected_result)
      end
    end
  end
end
