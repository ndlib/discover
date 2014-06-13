jQuery ($) ->
  $slider = $('#slider-range')
  if $slider.length > 0
    $start = $('#startdate')
    $end = $('#enddate')
    years = window.limits

    removePreviousDates = ->
      $sliderURL = $("#sliderURL")
      originalURL = $sliderURL.val()
      modifiedURL = originalURL
      nameMatches = originalURL.match(/fctN=[^&]+&?/g)
      valueMatches = originalURL.match(/fctV=[^&]+&?/g)
      $.each nameMatches, (index, nameMatch) ->
        if nameMatch.match(RegExp("=facet_creationdate"))
          valueMatch = valueMatches[index]
          modifiedURL = modifiedURL.replace(nameMatch, "")
          modifiedURL = modifiedURL.replace(valueMatch, "")
        return
      $sliderURL.val modifiedURL

    restrictCharacters = (event) ->
      keyValue = String.fromCharCode(event.which)
      if keyValue && /\D/.test(keyValue)
        event.preventDefault()
      return

    yearIndex = (year) ->
      year = parseInt(year)
      index = years.indexOf(year)
      if index == -1
        addYear(year)
        index = years.indexOf(year)
      index

    sortNumber = (a, b) ->
      a - b

    addYear = (year) ->
      years.push(parseInt(year))
      years.sort(sortNumber)
      $slider.slider("option", "max", years.length - 1)

    updateSlider = ->
      $slider.slider("values",0,yearIndex($start.val()))
      $slider.slider("values",1,yearIndex($end.val()))
      window.changeTooltipsHeadeValues($slider, $start.val(), $end.val())




    addEventHandlers = ->
      $start.attr('onblur', '').attr('onkeyup', '')
      $end.attr('onblur', '').attr('onkeyup', '')
      $start.keypress(restrictCharacters)
      $end.keypress(restrictCharacters)
      $start.blur(updateSlider)
      $end.blur(updateSlider)




    ready = ->
      removePreviousDates()
      addEventHandlers()

    $(document).ready(ready)
