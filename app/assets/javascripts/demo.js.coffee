jQuery ($) ->

  getOtherDetails = (element, tabType) ->
    link = $(element)
    recordID = EXLTA_recordId(element)
    if !link.data('loaded')
      success = (data) ->
        container = link.parents(".EXLResult").find("." + tabType + "-Container").children(".EXLTabContent").children(".EXLOtherDetailsTabContent")
        container.removeClass('EXLTabLoading')
        container.html data
        link.data('loaded', true)
        return
      $.get "/record", {id: recordID, primary: 'ndu_aleph'}, success, "html"
    return

  ready = ->
    EXLTA_addTab "New Details", "OtherDetailsTab", location.href, "EXLDetailsTab", "detailsTab", "otherDetailsTab", false, checkTabPresence, ".EXLDetailsTab"
    $(".OtherDetailsTab").click (e) ->
      tab = $(this)
      link = tab.find('a').get(0)
      msTabHandler e, link, "OtherDetailsTab", "<div id=\"ndOtherDetails\" class=\"EXLTabLoading EXLOtherDetailsTabContent\"></div>", getOtherDetails, location.href, tab.hasClass("EXLResultSelectedTab")
      return

  $(document).ready(ready)
