class PublisherCrawlerService
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def run
    save_stats
    save_links
  end

  private

  def save_stats
    AlexaStatsCrawler.new(domain).run.each do |domain_country_stats|
      DomainCountry.store(domain_country_stats)
    end
  end

  def save_links
    Website.store(SiteLinksCrawler.new(domain).run)
  end
end
