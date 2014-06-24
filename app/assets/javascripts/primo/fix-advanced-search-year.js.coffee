# Remove the 'Year' placeholder text when the user focuses on the year inputs
jQuery ($) ->
  ready = ->
    $('.EXLAdvancedSearchFormDateRangeRow input').each ->
      $input = $(this)
      $input.focus ->
        if $input.val() == 'Year'
          $input.val('')
      $input.blur ->
        if $input.val() == ''
          $input.val('Year')

  $(document).ready(ready)
