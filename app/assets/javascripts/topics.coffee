$(document).on 'click', '.node-a', (e) ->
  el = $(e.currentTarget)
  $("#node-selector").modal('hide')
  $nodeName = $(e.currentTarget).text()
  $nodeId = el.data('id')
  $('#node-selector-button').html($nodeName)
  $('#topic_node_id').val($nodeId)
  return false

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
