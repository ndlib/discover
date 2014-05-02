jQuery ($) ->
  cloneTabClass = "EXLDetailsTabDemo"
  ajaxPath = "/record"

  hoverIn = ->
    li = $(this)
    li.prevAll().addClass('ndl-hover')

  hoverOut = ->
    li = $(this)
    li.prevAll().removeClass('ndl-hover')

  attachEvents = (container) ->
    container.find('.ndl-hierarchical-search li').hover(hoverIn, hoverOut)

  getOtherDetails = (element, tabType) ->
    link = $(element)
    recordID = EXLTA_recordId(element)
    if !link.data('loaded')
      success = (data) ->
        container = link.parents(".EXLResult").find("." + tabType + "-Container").children(".EXLTabContent").children(".ndl-details-tab-content")
        container.removeClass('EXLTabLoading')
        container.html data
        link.data('loaded', true)
        attachEvents(container)
        return
      $.get ajaxPath, {id: recordID, primary: 'ndu_aleph'}, success, "html"
    return

  ready = ->
    replaceTab = $(".#{cloneTabClass}")
    if replaceTab.length > 0
      EXLTA_addTab "New Details", "ndl-details-tab", location.href, cloneTabClass, "detailsTab", "ndl-details-tab", false, checkTabPresence, ".#{cloneTabClass}"
      $(".ndl-details-tab").click (e) ->
        tab = $(this)
        link = tab.find('a').get(0)
        msTabHandler e, link, "ndl-details-tab", "<div id=\"ndlOtherDetails\" class=\"EXLTabLoading ndl-details-tab-content\"></div>", getOtherDetails, location.href, tab.hasClass("EXLResultSelectedTab")
        return
    $('.ndl-hierarchical-search li').hover(hoverIn, hoverOut)

  $(document).ready(ready)
