jQuery ($) ->
  newDetailsTab = (currentTab) ->
    newTab = currentTab.clone()
    newID = currentTab.attr('id').replace('Details', 'NewDetails')
    newClass = currentTab.attr('class').replace('Details', 'NewDetails')
    newTab.attr('id', newID)
    newTab.attr('class', newClass)
    newTab.find('a').text('New Details')
    newTab

  newDetailsTabContents = (currentTabContents) ->
    newTabContents = currentTabContents.clone()
    newID = currentTabContents.attr('id').replace('details', 'NewDetails')
    newClass = currentTabContents.attr('class').replace('details', 'NewDetails')
    newTabContents.attr('id', newID)
    newTabContents.attr('class', newClass)
    newTabContents

  ready = ->
    $('.EXLDetailsTab').each ->
      currentTab = $(this)
      container = currentTab.parents('.EXLSummary')
      currentTabContents = container.find('.EXLContainer-detailsTab')
      newTab = newDetailsTab(currentTab)
      newTab.insertAfter(currentTab)
      newTabContents = newDetailsTabContents(currentTabContents)
      newTabContents.insertAfter(currentTabContents)
      newTab.click (event) ->
        event.preventDefault()
        newTabContents.show()





  $(document).ready(ready)
  $(document).on('page:load', ready)
