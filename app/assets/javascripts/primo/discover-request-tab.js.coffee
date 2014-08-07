class RequestForm
  constructor: (@container) ->
    @form = @container.find('form')
    @volume_id = null
    @item_id = null
    @location_id = null
    @request_id = null
    @loading = false
    @attachEvents()
    @selectVolume(@find('.ndl-request-form-volume').val())

  find: (selector) ->
    @container.find(selector)


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
    @form.submit (event) ->
      event.preventDefault()
      object.submitForm()


  selectVolume: (volume_id) ->
    @volume_id = volume_id
    @find('.ndl-request-volume').hide()
    if volume_id
      $volumeContainer = @find("#ndl-request-volume-#{volume_id}")
      $volumeContainer.show()
      $itemSelect = $volumeContainer.find('.ndl-request-form-item')
      @selectItem($itemSelect.val())
    else
      @disableSubmit()

  selectItem: (item_id) ->
    @item_id = item_id
    @find('.ndl-request-item').hide()
    if item_id
      $itemContainer = @find("#ndl-request-item-#{item_id}")
      @request_id = $itemContainer.find('.ndl-request-form-request-id').val()
      $itemContainer.show()
      $locationSelect = $itemContainer.find('.ndl-request-form-location')
      @selectPickupLocation($locationSelect.val())
    else
      @request_id = null
      @disableSubmit()

  selectPickupLocation: (location_id) ->
    @location_id = location_id
    if location_id
      @enableSubmit()
    else
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

  formSuccess: ->
    @show('.ndl-request-success')
    @hide('.ndl-request')

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
      $.get "/primo_library/libweb/tiles/local/discover-request.jsp", {id: recordID, vid: window.currentVID, tab: window.currentTab}, success, "html"
    return

  ready = ->
    addRequestTab()
    $('.ndl-request-container').each ->
      new RequestForm($(this))

  $(document).ready(ready)
