class RequestForm
  constructor: (@container) ->
    @form = @container.find('form')
    @volume_id = null
    @item_id = null
    @location_id = null
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
    @find('#use_end_date').change ->
      if $(this).prop('checked')
        @find('.ndl-cancel_date_input').show()
      else
        @find('.ndl-cancel_date_input').hide()
    @form.submit (event) ->
      event.preventDefault()
      @submitForm()


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
      $itemContainer.show()
      $locationSelect = $itemContainer.find('.ndl-request-form-location')
      @selectPickupLocation($locationSelect.val())
    else
      @disableSubmit()

  selectPickupLocation: (location_id) ->
    @location_id = location_id
    if location_id
      @enableSubmit()
    else
      @disableSubmit()

  enableSubmit: ->
    @find('#ndl-request-form-submit-container').show()

  disableSubmit: ->
    @find('#ndl-request-form-submit-container').hide()

  submitForm: ->
    alert('submitted!')



jQuery ($) ->
  ready = ->
    $('.ndl-request').each ->
      new RequestForm($(this))

  $(document).ready(ready)
