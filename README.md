# statscrawler

Rails app that retrieves basic statistics about a given domain.

Highlights:
* Fetches the top 5 countries that visits the domain from alexa.com
* Counts the internal and external links going out from the homepage of the domain
* Uses Sidekiq to distribute processing
* It is configured to use SQLite, but it is capable of using any database

To run the crawler synchronously:
```
$ bin/rails c
irb(main):001:0> PublisherCrawler.new.perform('vice.com')
```

To run the crawler asynchronously:
```
$ bin/rails c
irb(main):001:0> PublisherCrawler.perform_async('vice.com')
```

To run the tests:
```
$ ruby test/run_test.rb
```
