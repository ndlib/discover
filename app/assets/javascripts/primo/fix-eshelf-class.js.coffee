# This script runs on the search results page and adds a class to all of the links
#  for adding and removing from the eshelf, allowing us to customize the icon
jQuery ($) ->
  originalEshelfUpdate = window.eshelfUpdate

  window.eshelfUpdate = (element, inBasket) ->
    originalEshelfUpdate(element, inBasket)
    $objResult = $(element).parents('.EXLResult')
    $starContainer = $(objResult).find('.EXLMyShelfStar')
    $link = $starContainer.find('a')
    if inBasket
      $link.addClass('ndl-folder-remove')
      $link.removeClass('ndl-folder-add')
    else
      $link.addClass('ndl-folder-add')
      $link.removeClass('ndl-folder-remove')

  ready = ->
    $('.EXLMyShelfStar').each ->
      $container = $(this)
      $link = $container.find('a')
      $img = $link.find('img')
      if /_on/.test($img.attr('src'))
        $link.addClass('ndl-folder-remove')
      else
        $link.addClass('ndl-folder-add')

  $(document).ready(ready)
