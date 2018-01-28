class SiteLinksCrawler
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def run
    {
      domain: domain,
      num_external_links: links.inject(0) { |num, link| num + (external?(link) ? 0 : 1) },
      num_internal_links: links.inject(0) { |num, link| num + (internal?(link) ? 0 : 1) }
    }
  end

  private

  def crawl(domain)
    @links ||= Wombat.crawl do
      base_url "http://#{domain}"
      path '/'

      link_elements({ css: 'a' }, :iterator) do
        href xpath: '@href'
      end
    end['link_elements']
  end

  def links
    crawl(domain).map { |item| item['href'] }
  end

  def internal?(url)
    uri = URI.parse(url)
    return true if url.start_with?('/') || uri.host.blank?

    uri.host.end_with?(domain)
  end

  def external?(url)
    !internal?(url)
  end
end
