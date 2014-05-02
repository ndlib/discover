jQuery ($) ->
  hoverIn = ->
    li = $(this)
    console.log(li)
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
      $.get "/record", {id: recordID, primary: 'ndu_aleph'}, success, "html"
    return

  ready = ->
    replaceTab = $('.EXLDetailsTabDemo')
    if replaceTab.length > 0
      EXLTA_addTab "New Details", "ndl-details-tab", location.href, "EXLDetailsTabDemo", "detailsTab", "ndl-details-tab", false, checkTabPresence, ".EXLDetailsTabDemo"
      $(".ndl-details-tab").click (e) ->
        tab = $(this)
        link = tab.find('a').get(0)
        msTabHandler e, link, "ndl-details-tab", "<div id=\"ndlOtherDetails\" class=\"EXLTabLoading ndl-details-tab-content\"></div>", getOtherDetails, location.href, tab.hasClass("EXLResultSelectedTab")
        return

  $(document).ready(ready)
