class AlexaStatsCrawler
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def run
    crawl(domain).map do |item|
      {
        domain: domain,
        country: item['country'],
        percentage: item['percentage']
      }
    end
  end

  private

  def crawl(domain)
    @countries ||= Wombat.crawl do
      base_url 'http://www.alexa.com'
      path "/siteinfo/#{domain}"

      countries({ css: '#demographics_div_country_table:not(.data-table-nodata) tbody tr' }, :iterator) do
        country(css: 'td:nth-of-type(1) a') { |country| country.delete("\u00A0").strip }
        percentage(css: 'td:nth-of-type(2) span') { |percentage| percentage.delete('%').to_f }
      end
    end['countries']
  end
end
