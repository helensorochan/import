require 'csv'

class Import::Parser

  attr_reader :status, :records

  def initialize(file_path)
    @file_path = file_path
  end

  def run
    @status = :started

    if @file_path.blank?
      @status = :interrupted
      return
    end

    @records = CSV.parse(File.new(@file_path).read, headers: true)

    @status = :finished
  end
end
