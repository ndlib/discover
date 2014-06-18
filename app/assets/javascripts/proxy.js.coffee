jQuery ($) ->

  window.addSessionId = (urlPrefix) ->
    sessionMatch = location.href.match(/;jsessionid=[^?]+/)
    if sessionMatch
      urlPrefix = urlPrefix + sessionMatch[0]
    urlPrefix

  window.openPrimoLightBox = (action, fn, elementReturned, additionalParameters, urlParameters, additionalSucessHandler, alignLightBox, clickedElement) ->
    $("#exliWhiteContent").css "z-index", "1002"
    addLoadingLBox()
    $("#exliLoadingFdb").css "top", 0
    addLightBoxDivs alignLightBox, clickedElement
    timestamp = new Date().getTime()
    url = ""
    mode = $("#mode").val()
    unless action is "searchDB"
      url = addSessionId(action + ".do") + "?fn=" + fn + "&ts=" + timestamp + additionalParameters
    else
      url = addSessionId(action + ".do") + "?fn=" + fn + "&ts=" + timestamp
      if additionalParameters is "IamDeepLink"
        document.getElementById("flagForFindDbDeepLink").title = "DeepLink"
      else
        if additionalParameters is "IamDeepLinkToMyDatabases"
          document.getElementById("flagForFindDbDeepLink").title = "DeepLinkToMyDatabases"
        else
          document.getElementById("flagForFindDbDeepLink").title = "NotADeepLink"
    url = url + "&mode=" + mode + "&" + urlParameters
    data = undefined
    $.ajax
      url: url
      data: data
      dataType: "xml"
      global: false
      beforeSend: (request) ->
        setAjaxRequestHeader request
        return

      error: (request, errorType, exceptionOcurred) ->
        if errorType is "timeout"
          notifyAjaxTimeout()
        else
          generalAjaxError()
        document.getElementById("exliLoadingFdb").style.display = "none"
        $("#exliLoadingFdb").css "top", 0
        document.getElementById("exliGreyOverlay").style.display = "none"
        document.getElementById("exliWhiteContent").style.display = "none"
        false

      success: (data) ->
        handleAjaxXmlRedirect data  if isAjaxXmlRedirect(data)
        elm = $(data).find(elementReturned)
        cdata = $(elm).text()
        n = undefined
        n = document.getElementById("exliWhiteContent")
        if additionalParameters is "IamDeepLinkToMyDatabases" & $(".EXLMyAccountSelectedTab").length > 0
          id = $(".EXLMyAccountSelectedTab").attr("id")
          $("#" + id).removeClass "EXLMyAccountSelectedTab"
          $("#exlidMyDatabasesTab").addClass "EXLMyAccountSelectedTab"
          $("#savedSelectedMyAccountTab").attr "title", id
        xmlText = cdata.replace(/\n\n/g, "\n").replace(/&lt;/g, "<").replace(/&gt;/g, ">")
        newdiv = document.createElement("div")
        newdiv.id = "exliPrimoLightBoxdiv"
        newdiv.innerHTML = xmlText
        n.innerHTML = ""
        $(n).append newdiv
        document.getElementById("exliLoadingFdb").style.display = "none"
        unless alignLightBox
          $("#exliLoadingFdb").css "top", 0
          $("#exliWhiteContent").show()
          $("#exliPrimoLightBoxdiv").attr("tabindex", -1).focus()
        else
          setLBPosition clickedElement, 1
          $("#exliWhiteContent").show()
          $("#exliWhiteContent").first("a").attr("tabindex", -1).focus()
        additionalSucessHandler additionalParameters  if additionalSucessHandler?
        return

    return
