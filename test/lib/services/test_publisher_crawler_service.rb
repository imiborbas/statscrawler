class TestPublisherCrawlerService < Test::Unit::TestCase
  def setup
    DatabaseCleaner.clean_with(:truncation)
  end

  def test_database_empty
    assert_empty(DomainCountry.all, 'The domain_countries table should be empty')
    assert_empty(Website.all, 'The websites table should be empty')
  end

  def test_run_creates_records
    VCR.use_cassette('end_to_end_vice') do
      PublisherCrawlerService.new('vice.com').run
    end

    assert_equal(5, DomainCountry.count, 'The domain_countries table should contain 5 records')
    assert_not_nil(DomainCountry.find_by(domain: 'vice.com', country: 'United States', percentage: 40.1))
    assert_not_nil(DomainCountry.find_by(domain: 'vice.com', country: 'United Kingdom', percentage: 7.2))
    assert_not_nil(DomainCountry.find_by(domain: 'vice.com', country: 'Canada', percentage: 5.8))
    assert_not_nil(DomainCountry.find_by(domain: 'vice.com', country: 'Germany', percentage: 5.4))
    assert_not_nil(DomainCountry.find_by(domain: 'vice.com', country: 'France', percentage: 3.8))

    assert_equal(1, Website.count, 'The websites table should contain one record')
    assert_not_nil(Website.find_by(domain: 'vice.com', num_external_links: 60, num_internal_links: 15))
  end
end
