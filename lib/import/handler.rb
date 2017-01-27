class Import::Handler

  attr_reader :status

  def initialize(file_path)
    @file_path = file_path
  end

  def run
    @status = :parsing
    parser = Import::Parser.new(@file_path)
    parser.run

    if parser.status != :finished
      @status = :parsing_interrupted
      return
    end

    @status = :saving
    saver = Import::Saver.new(parser.records)
    saver.run

    @status = saver.status
  end
end
