jQuery ($) ->
  newDetailsTab = (currentTab) ->
    newTab = currentTab.clone()
    newID = currentTab.attr('id').replace('Details', 'NewDetails')
    newClass = currentTab.attr('class').replace('Details', 'NewDetails')
    newTab.attr('id', newID)
    newTab.attr('class', newClass)
    newTab.find('a').text('New Details')
    newTab

  newDetailsTabContainer = (currentTabContainer) ->
    newTabContainer = currentTabContainer.clone()
    newID = currentTabContainer.attr('id').replace('details', 'NewDetails')
    newClass = currentTabContainer.attr('class').replace('details', 'NewDetails')
    newTabContainer.attr('id', newID)
    newTabContainer.attr('class', newClass)
    newTabContainer.html("""
      <div class="EXLTabHeader"><div class="EXLTabHeaderContent"></div></div>
      <div class="EXLTabContent EXLNewDetailsTabContent">
        <div class="EXLDetailsContent"></div>
      </div>
        """)
    newTabContainer

  ready = ->
    $('.EXLResult').each ->
      result = $(this)
      currentTab = result.find('.EXLDetailsTab')
      currentTabContainer = result.find('.EXLContainer-detailsTab')
      recordID = result.find('.EXLResultRecordId').attr('id')
      newTab = newDetailsTab(currentTab)
      newTab.insertAfter(currentTab)
      newTabContainer = newDetailsTabContainer(currentTabContainer)
      newTabContainer.insertAfter(currentTabContainer)
      contentsContainer = newTabContainer.find('.EXLNewDetailsTabContent')
      newTab.click (event) ->
        event.preventDefault()
        newTabContainer.siblings('.EXLResultTabContainer').hide()
        result.find('.EXLTabsRibbon').removeClass('EXLTabsRibbonClosed')
        result.find('.EXLResultSelectedTab').removeClass('EXLResultSelectedTab')
        newTab.addClass('EXLResultSelectedTab')
        newTabContainer.show()
        $.get '/record?id='+recordID, (data) ->
          contents = $(data).children()
          contentsContainer.html(contents)

  $(document).ready(ready)
