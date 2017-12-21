@FormStorage =
  init: ->
    if window.localStorage
      $(document).on 'input', 'textarea[name*=body]', ->
        textarea = $(this)
        localStorage.setItem(FormStorage.key(textarea), textarea.val())

  key: (element) ->
    "#{$(element).prop('id')}"

  restore: ->
    if window.localStorage
      $('textarea[name*=body]').each ->
        textarea = $(this)
        if value = localStorage.getItem(FormStorage.key(textarea))
          textarea.val(value)

FormStorage.init()
