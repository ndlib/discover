class RequestForm
  constructor: (@container) ->
    @form = @container.find('form')
    @record_title = @container.data('title')
    @volume_id = null
    @volume_title = null
    @item_id = null
    @institution_title = null
    @location_id = null
    @location_title = null
    @request_id = null
    @loading = false
    @attachEvents()
    @selectVolume(@find('.ndl-request-form-volume').val())

  find: (selector) ->
    @container.find(selector)

  itemContainer: ->
    @find("#ndl-request-item-#{@item_id}")

  isSingleVolume: ->
    @find('.ndl-request-single-volume').length > 0

  attachEvents: ->
    object = @
    @find('.ndl-request-form-volume').change ->
      volume_id = $(this).val()
      object.selectVolume(volume_id)
    @find('.ndl-request-form-item').change ->
      item_id = $(this).val()
      object.selectItem(item_id)
    @find('.ndl-request-form-location').change ->
      location_id = $(this).val()
      object.selectPickupLocation(location_id)
    @find('.ndl-request-book-link').click ->
      object.show('.ndl-step1-form')
      object.hide('.ndl-individual-links')

    date = @find('.date-pick')
    if date.datePicker
      date.datePicker()
    @form.submit (event) ->
      event.preventDefault()
      object.submitForm()


  selectVolume: (volume_id) ->
    @volume_id = volume_id
    @find('.ndl-request-volume').hide()
    if volume_id
      @hide('.ndl-request-success')
      @hide('.ndl-request-failure')
      $volumeContainer = @find("#ndl-request-volume-#{volume_id}")
      $volumeContainer.show()
      @volume_title = $volumeContainer.data('title')
      $itemSelect = $volumeContainer.find('.ndl-request-form-item')
      @selectItem($itemSelect.val())
    else
      @volume_title = null
      @disableSubmit()

  selectItem: (item_id) ->
    @item_id = item_id
    @find('.ndl-request-item').hide()
    if item_id
      $itemContainer = @itemContainer()
      @request_id = $itemContainer.find('.ndl-request-form-request-id').val()
      $itemContainer.show()
      @institution_title = $itemContainer.data('institution_title')
      $locationSelect = $itemContainer.find('.ndl-request-form-location')
      @selectPickupLocation($locationSelect.val())
    else
      @request_id = null
      @institution_title = null
      @disableSubmit()

  selectPickupLocation: (location_id) ->
    @location_id = location_id
    if location_id
      @location_title = @itemContainer().find('.ndl-request-form-location option:selected').text()
      @enableSubmit()
    else
      @location_title = null
      @disableSubmit()

  enableSubmit: ->
    @find('.ndl-request-form-submit-container').show()

  disableSubmit: ->
    @find('.ndl-request-form-submit-container').hide()

  formValues: ->
    {
      request_id: @request_id,
      pickup_location: @location_id,
      cancel_date: @find('.ndl-cancel-date').val(),
    }

  submitForm: ->
    if !@loading
      object = @
      object.showLoadingIcon()
      jQuery.post(@form.attr('action'), @formValues())
      .done ->
        object.formSuccess()
      .fail (jqXHR) ->
        object.formFailure(jqXHR)
      .always ->
        object.hideLoadingIcon()

  showLoadingIcon: ->
    @loading = true
    @show('.ndl-request-loading')

  hideLoadingIcon: ->
    @loading = false
    @hide('.ndl-request-loading')

  successMessage: ->
    message = "You requested #{@record_title}"
    if !@isSingleVolume()
      message += " #{@volume_title}"
    message += " from #{@institution_title} with the pickup location #{@location_title}"
    message

  formSuccess: ->
    @hide('.ndl-request-failure')
    @show('.ndl-request-success')
    @find('.ndl-request-success-message').text(@successMessage())
    @removeCurrentVolume()

  removeCurrentVolume: ->
    $volumeSelect = @find('.ndl-request-form-volume')
    $volumeOption = $volumeSelect.find('option[value="' + @volume_id + '"]')
    $volumeSelect.val('')
    $volumeOption.remove()
    @selectVolume(null)

  formFailure: (jqXHR) ->
    if jqXHR.status == 200
      # When the response comes through the discover-place-request.jsp file on Primo, it triggers the fail() callback even on a success.
      # Rather than debugging that problem, we capture the disparity at this point in the logic and show that it was a success.
      @formSuccess()
    else
      @show('.ndl-request-failure')
      messageContainer = @find('.ndl-request-failure-message')
      try
        body = jQuery.parseJSON(jqXHR.responseText)
        message = body.server_response
        messageContainer.text("Error message: #{message}")
        messageContainer.show()
      catch
        messageContainer.hide()



  show: (selector) ->
    @find(selector).removeClass('ndl-hidden')

  hide: (selector) ->
    @find(selector).addClass('ndl-hidden')

# end RequestForm

jQuery ($) ->
  addRequestTab = ->
    $('.EXLSummary').each (summary) ->
      if $(this).find('.request')
        createNewRequestTab($(this), 'Request', 'EXLRequestTab', location.href, "not-used", "not-used", true, 'EXLResultTab')

    window.addDiscoverTab('EXLRequestTab', 'ndl-request-tab', "Request", getRequestTab)

  getRequestTab = (element, tabType) ->
    link = $(element)
    recordID = EXLTA_recordId(element)
    if !link.data('loaded')
      success = (data) ->
        container = link.parents(".EXLResult").find("." + tabType + "-Container").children(".EXLTabContent").children(".#{tabType}-content")
        container.removeClass('EXLTabLoading')
        container.html data
        link.data('loaded', true)
        new RequestForm(container.find('.ndl-request-container'))
        return
      $.ajax(
        url: "/primo_library/libweb/tiles/local/discover-request.jsp"
        data: {id: recordID, vid: window.currentVID, tab: window.currentTab}
        success: success
        dataType: "html"
        cache: false
      )

  createNewRequestTab = (summaryElement, tabName, tabType, url, tabSelectorCopy, tabUrlReplace, tabUrlReplaceValue, firstTab,appendAfter,evaluator,evaluatorVar) ->
    element = summaryElement.find('.EXLResultTabs');
    if element.length > 0
      return
    customTab = $('<li class="EXLResultTab '+tabType+'"><a href="'+url+'">'+tabName+'</a></li>');
    customTabContainer = $('<div class="EXLResultTabContainer '+tabType+'-Container"></div>');
    if !evaluator || (evaluator && evaluator(element, evaluatorVar) == true)
      scu = $(element).parents('.EXLResult').find('.' + tabSelectorCopy + ' a').attr('href');
      if scu
        url = scu;
        url = url.replace('tabs='+tabUrlReplace, 'tabs='+tabUrlReplaceValue);

      if firstTab
        $(element).find('li').removeClass('EXLResultFirstTab');
        $(element).addClass('EXLResultFirstTab');
        $(element).prepend(customTab);
      else
        $(element).parents('.EXLResult').find('.' + appendAfter).after(customTab);

      result = $(element).parents('.EXLResult');
      if !EXLTA_isFullDisplay()  #Solves full display bug where container isn't added to page.
        result = result.find('.EXLSummary');

      result.append(customTabContainer);

    $('.EXLSummary .'+tabType+'-Container').hide();

  ready = ->
    addRequestTab()
    $('.ndl-request-container').each ->
      new RequestForm($(this))




  $(document).ready(ready)
