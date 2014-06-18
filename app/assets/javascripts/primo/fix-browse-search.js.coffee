# The browse search results page doesn't have any css class to distinguish it from the regular search results page.
# This adds a class to the body so we can style the form differently.
jQuery ($) ->
  browseRibbon = $('.EXLAdvancedBrowseRibbon')
  if browseRibbon.length > 0
    $('body').addClass('EXLBrowseSearch')
