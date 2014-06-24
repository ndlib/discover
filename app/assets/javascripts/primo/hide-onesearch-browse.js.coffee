# We don't want to show the "Browse Search" link on the onesearch tab
jQuery ($) ->
  tab = $('#tab').val()
  if tab == 'onesearch'
    $browseLink = $('.extra-links a').filter ->
      $(this).text() == 'Browse Search'
    $browseLink.hide()
