jQuery ($) ->
  window.currentVID = ''
  window.currentTab = ''
  originalDetailsTabClass = "EXLDetailsTab"
  originalOnlineAccessTabClass = "EXLViewOnlineTab"
  detailsPath = "/primo_library/libweb/tiles/local/discover-details.jsp"
  onlineAccessPath = "/primo_library/libweb/tiles/local/discover-online-access.jsp"
  detailsTabClass = 'ndl-details-tab'
  onlineAccessTabClass = 'ndl-online-access-tab'
  searchPhrase = ''
  searchTerms = []

  hoverIn = ->
    li = $(this)
    li.prevAll().add(li).addClass('ndl-hover')

  hoverOut = ->
    li = $(this)
    li.prevAll().add(li).removeClass('ndl-hover')

  buildSearchTerms = (phrase) ->
    terms = []
    if phrase
      phrase = phrase.trim()
      quoteRegex = /"([^"]+)"/
      while match = quoteRegex.exec(phrase)
        terms.push(match[1])
        phrase = phrase.replace(match[0], '').trim()
      phrase = phrase.replace(/AND|OR/g,"")
      phrase = phrase.replace(/[()]/g,"")
      phrase = phrase.replace(/\s+/g," ").trim()
      if phrase
        terms = terms.concat(phrase.split(' '))
    terms

  highlightSearchTerms = (element) ->
    element.highlight(searchTerms, {className: "searchword", wordsOnly: true})
    # Show any hidden items
    element.find('.ndl-collapsible-link .searchword').each ->
      highlightedElement = $(this)
      parent = highlightedElement.parents('.ndl-collapsible-link')
      parent.addClass('ndl-has-searchword').show()

  attachEvents = (container) ->
    container.find('.ndl-hierarchical-search li').hover(hoverIn, hoverOut)
    container.find('.ndl-detail-content > ul').each ->
      ul = $(this)
      lis = ul.children('li')
      if lis.length > 8
        fifth = $(lis[4])
        collapsibleLinks = fifth.nextAll()
        collapsibleLinks.addClass('ndl-hidden').addClass('ndl-collapsible-link')
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
        highlightSearchTerms(container)
        return
      $.get detailsPath, {id: recordID, vid: currentVID, tab: currentTab}, success, "html"

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

  window.addDiscoverTab = (originalTabClass, newTabClass, newTabName, loadTabFunction) ->
    originalTabs = $(".#{originalTabClass}")
    if originalTabs.length > 0
      EXLTA_addTab newTabName, newTabClass, location.href, originalTabClass, newTabClass, newTabClass, false, checkTabPresence, ".#{originalTabClass}"
      newTabs = $(".#{newTabClass}")
      # Click handler for loading the new tab content
      newTabs.click (e) ->
        tab = $(this)
        link = tab.find('a').get(0)
        failCallback = () ->
          # If the request to load the custom tab fails, we show the original Primo tab instead.
          # Click to hide the tab content loading area
          tab.click()
          # Hide the original tab which didn't load correctly
          tab.hide()
          originalTab = tab.siblings(".#{originalTabClass}")
          # Show the original tab
          originalTab.show()
          originalLink = originalTab.find('a')
          # If it's a popout we need to open the link in a new window
          if originalTab.hasClass('EXLResultTabIconPopout')
            # Open the new window
            window.open(originalLink.attr('href'), '_blank')
          else
            originalLink.click()
        callback = (element, tabType, url) ->
          request = loadTabFunction(element, tabType, url)
          if request && request.fail
            request.fail(failCallback)
        msTabHandler e, link, newTabClass, "<div id=\"#{newTabClass}-content\" class=\"EXLTabLoading #{newTabClass}-content\"></div>", callback, location.href, tab.hasClass("EXLResultSelectedTab")
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
          # $tab.siblings(".#{onlineAccessTabClass}").hide()
          # Temporarily show the findtext tab and hide the ILL tab
          $tab.siblings(".#{onlineAccessTabClass}").find("a").text(tabText)


  getCurrentVID = ->
    $vid = $('#vid')
    if $vid.length == 0
      # On the browse pages, the vid field has a different id
      $vid = $('#vid_browse_input')
    $vid.val()

  getCurrentTab = ->
    $('#tab').val()

  ready = ->
    window.currentVID = getCurrentVID()
    window.currentTab = getCurrentTab()
    searchPhrase = ""
    $('#search_field, #input_freeText0, #input_freeText1, input_freeText2').each ->
      searchPhrase += " " + $(this).val()
    searchTerms = buildSearchTerms(searchPhrase)
    addDetailsTab()
    addOnlineAccessTab()

    $('.ndl-details').each ->
      attachEvents($(this))

  $(document).ready(ready)
