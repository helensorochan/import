class Import::Saver

  attr_reader :status, :errors

  def initialize(records)
    @records = records
    @errors = []
  end

  def run
    @status = :started

    if @records.blank?
      @status = :data_missing
      return
    end

    @records.each{|attrs| save_record(attrs.to_hash)}

    @status = @errors.blank? ? :finished : :finished_with_errors
  end

  private

  def error_logger(record_attrs, messages)
    @errors << [record_attrs, messages]
  end

  def save_record(record_attrs)
    record = Product.new(record_attrs)
    record.save || error_logger(record_attrs, record.errors.full_messages)
  end
end
