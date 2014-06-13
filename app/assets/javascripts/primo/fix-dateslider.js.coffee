jQuery ($) ->
  $slider = $('#slider-range')
  if $slider.length > 0
    $sliderURL = $("#sliderURL")
    $start = $('#startdate')
    $end = $('#enddate')
    $dateSubmit = $('#dateSubmit')
    minYear = 1
    maxYear = new Date().getFullYear()
    years = window.limits

    removePreviousDates = ->
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

    getURL = ->
      url = $sliderURL.val()
      url = url.replace('fctN=xxx', "fctN=facet_creationdate")
      dateString = "fctV=%5b#{$start.val()}+TO+#{$end.val()}%5d"
      url = url.replace('fctV=xxx', dateString)
      url

    updateURL = ->
      $dateSubmit.attr('href', getURL())

    restrictCharacters = (event) ->
      keyValue = String.fromCharCode(event.which)
      if keyValue && /\D/.test(keyValue)
        event.preventDefault()
      return

    yearValue = (input) ->
      string = input.val().replace(/\D/g,'')
      if string == ''
        minYear
      else
        parseInt(string)

    updateStart = (event) ->
      startValue = yearValue($start)
      console.log(startValue)
      endValue = yearValue($end)
      if startValue < minYear
        startValue = minYear
      else if startValue > endValue
        startValue = endValue
      $start.val(startValue)
      updateSlider()

    updateEnd = (event) ->
      startValue = yearValue($start)
      endValue = yearValue($end)
      if endValue > maxYear
        endValue = maxYear
      else if endValue < startValue
        endValue = startValue
      $end.val(endValue)
      updateSlider()

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
      updateURL()
      startValue = yearValue($start)
      endValue = yearValue($end)
      $slider.slider("values",0,yearIndex(startValue))
      $slider.slider("values",1,yearIndex(endValue))
      window.changeTooltipsHeadeValues($slider, startValue, endValue)

    addEventHandlers = ->
      $start.attr('onblur', '').attr('onkeyup', '')
      $end.attr('onblur', '').attr('onkeyup', '')
      $start.keypress(restrictCharacters)
      $end.keypress(restrictCharacters)
      $start.blur(updateStart)
      $end.blur(updateEnd)
      $start.change(updateURL)
      $end.change(updateURL)

    ready = ->
      removePreviousDates()
      addEventHandlers()

    $(document).ready(ready)
