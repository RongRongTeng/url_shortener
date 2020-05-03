$(document).on 'turbolinks:load', ->
  return if $('.has-copied-tooltip').length == 0

  $('.has-copied-tooltip').on 'click', (e) ->
    $target = $(e.currentTarget).data('target')
    copyToClipboard document.getElementById($target)
    e.preventDefault()

  copyToClipboard = (target) ->
    body = document.body
    if (document.createRange && window.getSelection)
      range = document.createRange()
      sel = window.getSelection()
      sel.removeAllRanges()
      try
        range.selectNodeContents(target)
        sel.addRange(range)
        document.execCommand("Copy");
      catch e
        range.selectNodeContents(target)
        sel.addRange(range)
    else if (body.createTextRange)
      range = body.createTextRange()
      range.moveToElementText(target)
      range.select()
      range.execCommand("Copy")
    return
