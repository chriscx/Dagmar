cheerio = require('cheerio')

url = 'http://www.echojs.com/'

download url, (data) ->
  if data
    # console.log(data);
    $ = cheerio.load(data)
    $('article').each (i, e) ->
      link = $(e).find('h2>a')
      poster = $(e).find('username').text()
      console.log poster + ': [' + link.html() + '](' + link.attr('href') + ')'
