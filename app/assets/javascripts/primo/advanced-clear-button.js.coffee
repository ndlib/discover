# Adds a "Clear" button on the advanced search form that will refresh the page and blank out the advanced search form
jQuery ($) ->
  form = $('#searchForm')
  mode = $('#mode')
  if form.find('.search-appliance').length > 0 && mode.val() == 'Advanced'
    submitButton = form.find('input[type=submit]')
    clearButton = $('<input type="reset" id="clearForm" class="submit clear-button" value="Clear">')
    submitButton.parent().prepend(clearButton)

    clearButton.click (event) ->
      event.preventDefault()
      params = $('#tab, #vid, #mode').serialize()
      path = form.attr('action').replace(/\?.*/,'')
      window.location = path + '?' + params
