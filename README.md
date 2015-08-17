# Dagmar

Dagmar is a deadly simple crawling/scraping package for Node.

It features:
 * A clean, simple API
 * Possible use of server-side DOM & automatic jQuery insertion with Cheerio
 * node 0.10 and 0.12 support

## How to install

    $ npm install crawler

## Crash course

```coffeescript

crawler = new Crawler()

crawler.do((error, response, body) ->
  if error or response.statusCode != 200
    console.log error
  else
      crawler.next()
)

crawler.queue("http://www.google.com")
crawler.queue("http://www.yahoo.com")
crawler.queue("http://www.apple.com")
crawler.queue("http://www.twitter.com")
crawler.queue("http://www.facebook.com")

crawler.start()

```

## Using Cheerio

```coffeescript

crawler = new Crawler()

crawler.do((error, response, body) ->
  if !error and response.statusCode == 200
    $ = cheerio.load body
    list = $ 'ul', '<ul id="fruits">...</ul>'
    console.log list
  else
    console.log error
  crawler.next()
)

crawler.queue("http://www.fruits.org")

crawler.start()

```

## Full crawler retrieving href and adding to queue

```coffeescript
crawler = new Crawler()

crawler.do((error, response, body) ->
  if !error and response.statusCode == 200
    $ = cheerio.load body
    $('a').each (index, a) ->
      url = $(a).attr('href')
      crawler.queue url
  else
    console.log error
  crawler.next()
)

crawler.queue("http://www.fruits.org")

crawler.start()
```
