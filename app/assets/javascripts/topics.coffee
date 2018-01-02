class TopicView
  clearTextArea: ->
    $('#reply_body').val('')
    $("#new_reply textarea").focus()

  resetClearReplyHightTimer: ->
    clearHightTimer = setTimeout('$(".reply").removeClass("light")',10000)

  initializeLikeable: ->
    $('[data-toggle="popover"]').popover(
      container: "body",
      trigger: "hover",
      html: true,
      placement: 'bottom',
      delay:
        hide: 100
    ).on('shown.bs.popover', (event) ->
        $('.popover').on('mouseenter', () ->
          $('.popover').attr('in', true)
        ).on('mouseleave', () ->
          $('.popover').removeAttr('in')
          $('.popover').popover('hide')
        )
      ).on('hide.bs.popover', (event) ->
        if ($('.popover').attr('in'))
          event.preventDefault()
    )

$(document).on 'click', '.node-a', (e) ->
  el = $(e.currentTarget)
  $("#node-selector").modal('hide')
  if $('.form input[name="topic[node_id]"]').length > 0
    $nodeName = $(e.currentTarget).text()
    $nodeId = el.data('id')
    $('#node-selector-button').html($nodeName)
    $('#topic_node_id').val($nodeId)
    return false
  else
    return true

$(document).on 'click', '.insert-codes',(e) ->
  link = $(e.currentTarget)
  language = link.data("lang")
  txtBox = $(".topic-editor")
  caret_pos = txtBox.caret('pos')
  prefix_break = ""
  if txtBox.val().length > 0
    prefix_break = "\n"
  src_merged = "#{prefix_break }```#{language}\n\n```\n"
  source = txtBox.val()
  before_text = source.slice(0, caret_pos)
  txtBox.val(before_text + src_merged + source.slice(caret_pos+1, source.count))
  txtBox.caret('pos',caret_pos + src_merged.length - 5)
  txtBox.focus()
  txtBox.trigger('click')
  return false

$(document).on 'click', '.preview', ->
  $("#preview").show()
  $('.topic-editor').hide()
  if $("#preview").length == 0
    preview_box = $(document.createElement("div"))
    preview_box.attr("id", "preview").attr("rows", '20')
    preview_box.addClass("markdown form-control")
    $('.topic-editor').after preview_box
    $('.topic-editor').hide()
    preview_box.show()

  $("#preview").text "Loading..."
  body = $('.topic-editor').val()
  $.post "/topics/preview",
    "body": body,
    (data) ->
      $("#preview").html (data.body)
  return false

$(document).on 'click', '.edit', ->
  $('.topic-editor').show()
  $('#preview').hide()
  return false

window.topicView = new TopicView()
