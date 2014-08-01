jQuery ($) ->
  $container = $('#ndl-request-form')
  currentVolume = null
  currentItem = null
  currentLocation = null

  setupForm = ->
    if $container.length > 0
      $('#ndl-request-form-volume').change ->
        volume_id = $(this).val()
        selectVolume(volume_id)
      $('.ndl-request-form-item').change ->
        item_id = $(this).val()
        selectItem(item_id)
      $('.ndl-request-form-location').change ->
        location_id = $(this).val()
        selectPickupLocation(location_id)

      selectVolume($('#ndl-request-form-volume').val())

  selectVolume = (volume_id) ->
    currentVolume = volume_id
    $('.ndl-request-volume').hide()
    if volume_id
      $volumeContainer = $("#ndl-request-volume-#{volume_id}")
      $volumeContainer.show()
      $itemSelect = $volumeContainer.find('.ndl-request-form-item')
      selectItem($itemSelect.val())
    else
      disableSubmit()

  selectItem = (item_id) ->
    currentItem = item_id
    $('.ndl-request-item').hide()
    if item_id
      $itemContainer = $("#ndl-request-item-#{item_id}")
      $itemContainer.show()
      $locationSelect = $itemContainer.find('.ndl-request-form-location')
      selectPickupLocation($locationSelect.val())
    else
      disableSubmit()

  selectPickupLocation = (location_id) ->
    currentLocation = location_id
    if location_id
      enableSubmit()
    else
      disableSubmit()

  enableSubmit = ->
    $('#ndl-request-form-submit-container').show()

  disableSubmit = ->
    $('#ndl-request-form-submit-container').hide()

  ready = ->
    setupForm()

  $(document).ready(ready)
