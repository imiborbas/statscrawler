class TestSiteLinksCrawler < Test::Unit::TestCase
  def test_run
    crawler = SiteLinksCrawler.new('vice.com')

    expected = {
      domain: 'vice.com',
      num_external_links: 60,
      num_internal_links: 15
    }

    VCR.use_cassette('vice_home') do
      assert_equal(expected, crawler.run, 'Should return the specified hash')
    end
  end
end
