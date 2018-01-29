class TestAlexaStatsCrawler < Test::Unit::TestCase
  def test_run_stats_present
    crawler = AlexaStatsCrawler.new('vice.com')

    expected = [
      { domain: 'vice.com', country: 'United States', percentage: 40.1 },
      { domain: 'vice.com', country: 'United Kingdom', percentage: 7.2 },
      { domain: 'vice.com', country: 'Canada', percentage: 5.8 },
      { domain: 'vice.com', country: 'Germany', percentage: 5.4 },
      { domain: 'vice.com', country: 'France', percentage: 3.8 }
    ]

    VCR.use_cassette('alexa_vice') do
      assert_equal(expected, crawler.run, 'Should return the specified list of hashes')
    end
  end

  def test_run_stats_missing
    crawler = AlexaStatsCrawler.new('imiborbas.com')

    VCR.use_cassette('alexa_imiborbas') do
      assert_equal([], crawler.run, 'Should return an empty list')
    end
  end
end
