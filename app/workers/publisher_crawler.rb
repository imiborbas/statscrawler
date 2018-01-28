class PublisherCrawler
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform(domain)
    PublisherCrawlerService.new(domain).run
  end
end
