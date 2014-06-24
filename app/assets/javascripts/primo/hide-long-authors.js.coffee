# We don't want to show the "Browse Search" link on the onesearch tab
jQuery ($) ->
  ready = ->
    $('.EXLResultAuthor').each ->
      $author = $(this)
      original = $author.text()
      $author.attr('title', original)
      if original.length > 150
        short = original.substr(0, 120)
        shortArray = short.split(' ')
        shortArray.pop()
        short = shortArray.join(' ')
        $author.text(short)
        $author.append('&hellip;')

  $(document).ready(ready)
