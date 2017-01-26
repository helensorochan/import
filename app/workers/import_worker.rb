class ImportWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'import', retry: false

  def perform(file_path)
  end
end