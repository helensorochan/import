class ImportWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'import', retry: false

  def perform(file_path)
    Import::Handler.new(file_path).run
  end
end