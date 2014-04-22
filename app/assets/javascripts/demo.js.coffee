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
    $('.EXLResult').each ->
      result = $(this)
      currentTab = result.find('.EXLDetailsTab')
      currentTabContents = result.find('.EXLContainer-detailsTab')
      recordID = result.find('.EXLResultRecordId').attr('id')
      newTab = newDetailsTab(currentTab)
      newTab.insertAfter(currentTab)
      newTabContents = newDetailsTabContents(currentTabContents)
      newTabContents.insertAfter(currentTabContents)
      newTab.click (event) ->
        event.preventDefault()
        $.get '/record?id='+recordID, (data) ->
          console.log('hi')
          console.log(data)
          newTabContents.html(data)
          newTabContents.show()

  $(document).ready(ready)
