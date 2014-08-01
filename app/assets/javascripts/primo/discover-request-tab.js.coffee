jQuery ($) ->
  $container = $('#ndl-request-form')
  setupForm = ->
    if $container.length > 0
      selectVolume(null)
      $('#ndl-request-form-volume').change ->
        volume_id = $(this).val()
        selectVolume(volume_id)

  selectVolume = (volume_id) ->
    $('.ndl-request-volume').hide()
    if volume_id
      $("#ndl-request-volume-#{volume_id}").show()


  ready = ->
    setupForm()

  $(document).ready(ready)
