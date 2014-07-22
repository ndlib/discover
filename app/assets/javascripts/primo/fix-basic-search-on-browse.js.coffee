# In browse search (http://primo-fe1.library.nd.edu:1701/primo_library/libweb/action/search.do?fn=showBrowse&mode=BrowseSearch&dscnt=0&vid=NDU)
# direct the "Basic Search" link to the ND Catalog tab. i.e., add the parameter "?tab=nd_campus".

# Add a link to the advanced search page when in the Browse view

jQuery ($) ->
  ready = ->
    if $('body').hasClass('EXLBrowseSearch')
      # Grab the current href value to retain things like sessionid then append nd_campus
      searchURL =  $('.EXLSearchFieldRibbonFormLinks a[title="Basic Search"]').attr("href")
      $('.EXLSearchFieldRibbonFormLinks a[title="Basic Search"]').attr("href", searchURL + "?tab=nd_campus&mode=Basic")

      # Add a link to advanced search
      $(".EXLSearchFieldRibbonFormLinks").append('&nbsp;&nbsp;<a href="' + searchURL + '?tab=nd_campus&mode=Advanced" title="Advanced Search">Advanced Search</a>')
  $(document).ready(ready)
