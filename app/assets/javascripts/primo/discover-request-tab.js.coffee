jQuery ($) ->
  $container = $('#ndl-request-form')
  setupForm = ->
    if $container.length > 0
      selectVolume(null)
      $('#ndl-request-form-volume').change ->
        volume_id = $(this).val()
        selectVolume(volume_id)
      $('.ndl-request-form-item').change ->
        item_id = $(this).val()
        selectItem(item_id)

  selectVolume = (volume_id) ->
    $('.ndl-request-volume').hide()
    if volume_id
      $volumeContainer = $("#ndl-request-volume-#{volume_id}")
      $volumeContainer.show()
      $itemSelect = $volumeContainer.find('.ndl-request-form-item')
      selectItem($itemSelect.val())

  selectItem = (item_id) ->
    $('.ndl-request-item').hide()
    if item_id
      $("#ndl-request-item-#{item_id}").show()


  ready = ->
    setupForm()

  $(document).ready(ready)
