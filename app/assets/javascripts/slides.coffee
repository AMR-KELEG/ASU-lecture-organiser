# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->
  keymap = {}
  keymap[37] = '#prev'
  keymap[39] = '#next'
  $(document).on 'keyup', (event) ->
    selector = keymap[event.which]
    if selector
      href = $(selector).attr('href')
      if href
        window.location = href
    return
  return
