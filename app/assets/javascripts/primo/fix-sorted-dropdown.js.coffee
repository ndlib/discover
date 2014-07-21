# We've added two new local sort options in Primo (date oldest and call number).
# Since these are locally defined they don't work with Primo Central records, so
# we exclude them in the OneSearch tab.

jQuery ($) ->
  ready = ->
    if $('#tab').val() == "onesearch"
      $('.EXLSortByLink a[href^="search.do?srt=lso"]').parent().remove()
  $(document).ready(ready)
