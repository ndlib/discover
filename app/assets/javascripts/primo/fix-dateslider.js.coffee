jQuery ($) ->
  $slider = $('#slider-range')
  if $slider.length > 0
    $sliderURL = $("#sliderURL")
    $start = $('#startdate')
    $end = $('#enddate')
    $dateSubmit = $('#dateSubmit')
    minYear = 1
    maxYear = new Date().getFullYear()
    # By default Primo creates an array of years to show in the slider
    # We are going to modify that array in order to allow years that fall outside of that range
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

    hideLink = ->
      $dateSubmit.hide()

    showLink = ->
      $dateSubmit.show()

    getURL = ->
      showLink()
      url = $sliderURL.val()
      url = url.replace('fctN=xxx', "fctN=facet_creationdate")
      dateString = "fctV=%5b#{padYear($start.val())}+TO+#{padYear($end.val())}%5d"
      url = url.replace('fctV=xxx', dateString)
      url

    padYear = (year) ->
      year = '' + year
      pad = "0000"
      pad.substring(0, pad.length - year.length) + year

    updateURL = ->
      $dateSubmit.attr('href', getURL())

    gotoURL = ->
      window.location.href = getURL()

    restrictKeyPress = (event) ->
      keyValue = String.fromCharCode(event.which)
      if keyValue && /\D/.test(keyValue)
        event.preventDefault()
      return

    restrictKeyUp = (event) ->
      input = $(this)
      newValue = input.val().replace(/\D/g,'')
      if newValue != input.val()
        input.val(newValue)
      return

    yearValue = (input) ->
      string = input.val().replace(/\D/g,'')
      if string == ''
        minYear
      else
        parseInt(string)

    submitStart = (event) ->
      if event.which == 13
        updateStart()
        gotoURL()

    submitEnd = (event) ->
      if event.which == 13
        updateEnd()
        gotoURL()

    updateStart = (event) ->
      startValue = yearValue($start)
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
      $inputs = $start.add($end)
      $inputs.attr('onblur', '').attr('onkeyup', '')
      # Set a numeric pattern to bring up the number keyboard for touch screens
      $inputs.attr('pattern', '[0-9]*')
      $inputs.keypress(restrictKeyPress)
      $inputs.keyup(restrictKeyUp)
      $inputs.keyup(showLink)
      $inputs.change(updateURL)
      $start.blur(updateStart)
      $end.blur(updateEnd)
      $start.keypress(submitStart)
      $end.keypress(submitEnd)
      $slider.on "slidestop", updateSlider

    ready = ->
      removePreviousDates()
      hideLink()
      addEventHandlers()

    $(document).ready(ready)
