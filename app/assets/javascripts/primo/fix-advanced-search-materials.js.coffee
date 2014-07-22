# Some locally available media types are not available to OneSearch and some media types are not
# available locally so we hide them.

jQuery ($) ->
  ready = ->
    if $("#mode").val() == "Advanced"
      if $('#tab').val() == "onesearch"
        $("#exlidInput_mediaType_ option#mediaType_audio").remove()
        $("#exlidInput_mediaType_ option#mediaType_microform").remove()
        $("#exlidInput_mediaType_ option#mediaType_newspapers").remove()
        $("#exlidInput_mediaType_ option#mediaType_videos").remove()
      else
        $("#exlidInput_mediaType_ option#mediaType_articles").remove()
        $("#exlidInput_mediaType_ option#mediaType_audio_video").remove()
        $("#exlidInput_mediaType_ option#mediaType_newspaper_article").remove()
        $("#exlidInput_mediaType_ option#mediaType_reference_entrys").remove()
  $(document).ready(ready)
