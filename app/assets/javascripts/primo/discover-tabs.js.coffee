jQuery ($) ->
  currentVID = ''
  currentTab = ''
  originalDetailsTabClass = "EXLDetailsTab"
  originalOnlineAccessTabClass = "EXLViewOnlineTab"
  detailsPath = "/primo_library/libweb/tiles/local/discover-details.jsp"
  onlineAccessPath = "/primo_library/libweb/tiles/local/discover-online-access.jsp"
  detailsTabClass = 'ndl-details-tab'
  onlineAccessTabClass = 'ndl-online-access-tab'

  hoverIn = ->
    li = $(this)
    li.prevAll().add(li).addClass('ndl-hover')

  hoverOut = ->
    li = $(this)
    li.prevAll().add(li).removeClass('ndl-hover')

  attachEvents = (container) ->
    container.find('.ndl-hierarchical-search li').hover(hoverIn, hoverOut)
    container.find('.ndl-detail-content > ul').each ->
      ul = $(this)
      lis = ul.children('li')
      if lis.length > 8
        fifth = $(lis[4])
        collapsibleLinks = fifth.nextAll()
        collapsibleLinks.addClass('ndl-hidden')
        expandLi = $('<li></li>').addClass('ndl-expand')
        expandA = $('<a></a>').attr('href','#').text('Show More')
        expandLi.append(expandA)
        ul.append(expandLi)
        expandLi.click (event) ->
          event.preventDefault()
          if expandLi.hasClass('ndl-expand')
            expandLi.removeClass('ndl-expand')
            expandA.text('Show Less')
            collapsibleLinks.removeClass('ndl-hidden')
          else
            expandLi.addClass('ndl-expand')
            expandA.text('Show More')
            collapsibleLinks.addClass('ndl-hidden')
      return


  getOtherDetails = (element, tabType) ->
    link = $(element)
    recordID = EXLTA_recordId(element)
    if !link.data('loaded')
      success = (data) ->
        container = link.parents(".EXLResult").find("." + tabType + "-Container").children(".EXLTabContent").children(".#{tabType}-content")
        container.removeClass('EXLTabLoading')
        container.html data
        link.data('loaded', true)
        attachEvents(container)
        return
      $.get detailsPath, {id: recordID, vid: currentVID, tab: currentTab}, success, "html"
    return

  getOnlineAccess = (element, tabType) ->
    link = $(element)
    recordID = EXLTA_recordId(element)
    if !link.data('loaded')
      success = (data) ->
        container = link.parents(".EXLResult").find(".#{tabType}-Container").children(".EXLTabContent").children(".#{tabType}-content")
        container.removeClass('EXLTabLoading')
        container.html data
        link.data('loaded', true)
        return
      $.get onlineAccessPath, {id: recordID, vid: currentVID, tab: currentTab}, success, "html"
    return

  window.addDiscoverTab = (originalTabClass, newTabClass, newTabName, loadTabFunction) ->
    originalTabs = $(".#{originalTabClass}")
    if originalTabs.length > 0
      EXLTA_addTab newTabName, newTabClass, location.href, originalTabClass, newTabClass, newTabClass, false, checkTabPresence, ".#{originalTabClass}"
      newTabs = $(".#{newTabClass}")
      # Click handler for loading the new tab content
      newTabs.click (e) ->
        tab = $(this)
        link = tab.find('a').get(0)
        msTabHandler e, link, newTabClass, "<div id=\"#{newTabClass}-content\" class=\"EXLTabLoading #{newTabClass}-content\"></div>", loadTabFunction, location.href, tab.hasClass("EXLResultSelectedTab")
        return
      # Insert the new tab before its original counterpart
      newTabs.each ->
        newTab = $(this)
        originalTab = newTab.siblings(".#{originalTabClass}")
        originalTab.before(newTab)
        # Automatically load the new tab if the original tab is already selected
        if originalTab.hasClass('EXLResultSelectedTab')
          newTab.click()

  addDetailsTab = ->
    addDiscoverTab(originalDetailsTabClass, detailsTabClass, "Details", getOtherDetails)

  addOnlineAccessTab = ->
    originalTab = $(".#{originalOnlineAccessTabClass}")
    if originalTab.length > 0
      addDiscoverTab(originalOnlineAccessTabClass, onlineAccessTabClass, "Access Online", getOnlineAccess)
      findtextRegex = /findtext/i
      originalTab.each ->
        $tab = $(this)
        tabText = $tab.find('a').text()
        if findtextRegex.test(tabText)
          $tab.siblings(".#{onlineAccessTabClass}").hide()



  ready = ->
    $vid = $('#vid')
    if $vid.length == 0
      # On the browse pages, the vid field has a different id
      $vid = $('#vid_browse_input')
    currentVID = $vid.val()
    currentTab = $('#tab').val()
    addDetailsTab()
    addOnlineAccessTab()

    $('.ndl-details').each ->
      attachEvents($(this))

  $(document).ready(ready)
