require 'rails_helper'

RSpec.describe Import::Saver do

  def saver(file_path)
    parser = Import::Parser.new(file_path)
    parser.run
    saver = described_class.new(parser.records)
    saver.run
    saver
  end

  def error_message(attribute, type, options={})
    message = Product.new.errors.generate_message(attribute, type, options)
    Product.new.errors.full_message(attribute, message)
  end

  describe '#status' do

    subject { saver(file_path).status }

    context 'when file empty and saver run with blank records' do
      let(:file_path){ 'spec/fixtures/empty_file.csv' }

      it 'should equal data_missing' do
        expect(subject).to eq(:data_missing)
      end
    end

    context 'when wrong file format and saver run with blank records' do
      let(:file_path){ 'spec/fixtures/test.txt' }

      it 'should equal data_missing' do
        expect(subject).to eq(:data_missing)
      end
    end

    context 'when saver run with valid records' do
      let(:file_path){ 'spec/fixtures/valid_records.csv' }

      it 'should equal data_missing' do
        expect(subject).to eq(:finished)
      end
    end

    context 'when saver run with invalid records' do
      let(:file_path){ 'spec/fixtures/invalid_records.csv' }

      it 'should equal data_missing' do
        expect(subject).to eq(:finished_with_errors)
      end
    end
  end

  describe '#errors' do

    subject { saver(file_path).errors }

    context 'when file empty and saver run with blank records' do
      let(:file_path){ 'spec/fixtures/empty_file.csv' }

      it 'should equal be_empty' do
        expect(subject).to be_empty
      end
    end

    context 'when wrong file format and saver run with blank records' do
      let(:file_path){ 'spec/fixtures/test.txt' }

      it 'should be empty' do
        expect(subject).to be_empty
      end
    end

    context 'when saver run with valid records' do
      let(:file_path){ 'spec/fixtures/valid_records.csv' }

      it 'should be_empty' do
        expect(subject).to be_empty
      end
    end

    context 'when save invalid record' do
      let(:file_path){ 'spec/fixtures/invalid_records.csv' }

      it 'should not be empty' do
        errors = subject
        expect(errors.first.second).to match_array([error_message(:price, :invalid),
                                                    error_message(:price, :greater_than, count: 0)])
        expect(errors.last.second).to match_array([error_message(:sku, :taken)])
      end
    end
  end

  describe 'saving records' do
    subject { saver(file_path) }

    context 'when saver run with valid records' do
      let(:file_path){ 'spec/fixtures/valid_records.csv' }

      it 'should store products' do
        expect{saver(file_path)}.to change { Product.count }.from(0).to(1)
      end
    end
  end
end
