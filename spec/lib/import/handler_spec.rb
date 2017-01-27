require 'rails_helper'

RSpec.describe Import::Handler do

  subject(:import) { described_class.new(file_path) }

  describe '#status' do
    context 'when import run without file' do
      let(:file_path){ nil }

      it 'should equal interrupted' do
        import.run
        expect(import.status).to eq(:parsing_interrupted)
      end
    end

    context 'when import run with wrong format' do
      let(:file_path){ 'spec/fixtures/test.txt' }

      it 'should equal data missing' do
        import.run
        expect(import.status).to eq(:data_missing)
      end
    end

    context 'when import run with empty file' do
      let(:file_path){ 'spec/fixtures/empty_file.csv' }

      it 'should equal data missing' do
        import.run
        expect(import.status).to eq(:data_missing)
      end
    end

    context 'when import run with invalid records' do
      let(:file_path){ 'spec/fixtures/invalid_records.csv' }

      it 'should equal finished with errors' do
        import.run
        expect(import.status).to eq(:finished_with_errors)
      end
    end


    context 'when import run with valid records' do
      let(:file_path){ 'spec/fixtures/valid_records.csv' }

      it 'should equal finished' do
        import.run
        expect(import.status).to eq(:finished)
      end
    end
  end
end
