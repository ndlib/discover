# Add a WorldCat search link to Primo
jQuery ($) ->
  vid = null
  getWCIndex = (exSearch) ->
    switch exSearch
      when "any"
        "kw"
      when "title"
        "ti"
      when "creator"
        "au"
      when "sub"
        "su"
      when "isbn"
        "bn"
      when "issn"
        "n2"
      when "lsr03"
        "se"
      when "lsr04"
        "ut"
      when "lsr06"
        "pb"
      when "lsr05"
        "lc"
      else
        "kw"

  worldCatURL = (searchString) ->
    if searchString
      url = "http://www.worldcat.org/search?q=#{encodeURIComponent(searchString)}"


  proxiedWorldCatURL = (searchString) ->
    if url = worldCatURL(searchString)
      if vid == "NDU"
        url = "https://login.proxy.library.nd.edu/login?url=#{url}"
      else if vid == "BCI"
        url = "https://bcezproxy.bethelcollege.edu/login?url=#{url}"
      url


  addWorldCatLink = (searchString, mode = "Basic") ->
    if url = proxiedWorldCatURL(searchString)
      #expand width of parent container
      $(".EXLSearchTabsContainer").css "width", "100%"
      containerClass = "ndl-worldcat-link ndl-worldcat-link-#{mode.toLowerCase()}"
      #add the worldcat link
      $link = $("<a target=\"_blank\"><img src=\"../images/worldcat.png\" /></a>")
        .attr("href", url)
      $container = $("<div></div>")
        .attr("id", "WorldCat#{mode}Div")
        .addClass(containerClass)
        .append($link)
      $(".EXLSearchTabsContainer").append $container

  getVID = ->
    $vid = $('#vid')
    if $vid.length == 0
      # On the browse pages, the vid field has a different id
      $vid = $('#vid_browse_input')
    vid = $vid.val()

  ready = ->
    getVID()
    #advanced search
    if $("#exlidAdvancedSearchRibbon").length
      searchString = ""
      #loop through each advanced search row
      $(".EXLAdvancedSearchFormRow").each (index) ->
        #as long as free text is entered
        $input = $("#input_freeText" + index)
        if $input.length > 0 and $input.val()
          #the dropdowns start with 1
          ddIndex = index + 1
          #convert the search type from what's in the dropdown to worldcat's term
          wcIndex = getWCIndex($("#exlidInput_scope_" + ddIndex).val())
          if $("#exlidInput_precisionOperator_" + ddIndex).val() is "exact"
            #for 'exact' search
            operator = "="
          else
            #for 'contains'search
            operator = ":"
          #construct search string
          if searchString
            searchString += " "
          searchString += wcIndex + operator + $input.val()

      #also language search
      $language = $("#exlidInput_language_")
      if $language.length && $language.val() && $language.val() != "all_items"
        if searchString
          searchString += " "
        searchString += "ln:" + $language.val()

      addWorldCatLink(searchString, "Advanced")
    else
      #basic search
      unless $("#search_field").val() is ""
        searchTerm = $("#search_field").val()
        addWorldCatLink(searchTerm, "Basic")

  $(document).ready(ready)
