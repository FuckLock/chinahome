#= require jquery3
#= require jquery_ujs
#= require turbolinks
#= require popper
#= require bootstrap-sprockets
#= require topics
#= require_self
#= require jquery.atwho
#= require form_storage

window.App =
  alert : (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert alert-warning'><a class='close' href='#' data-dismiss='alert'><i class='fa fa-close'></i></a>#{msg}</div>")

$(document).on 'ajax:error', '#new_user', (event, xhr, status, error) ->
  App.alert(xhr.responseText, '#main')

$(document).on 'click', '.button-block-node', (e) ->
  btn = $(e.currentTarget)
  nodeId = btn.data('id')
  span = btn.find("span")
  if btn.hasClass("active")
    $.post("/nodes/#{nodeId}/unblock")
    btn.removeClass('active')
    span.text("忽略节点")
  else
    $.post("/nodes/#{nodeId}/block")
    btn.addClass('active')
    span.text("取消屏蔽")
  return false

$(document).on 'click', '.buttons-heart', (e) ->
  btn = $(e.currentTarget)
  topicId = btn.data('id')
  span = btn.find("span")
  if btn.hasClass("active")
    $.post("/topics/#{topicId}/unlike", (data) ->
      likeTopicCount = data.data
      if  likeTopicCount > 0
        span.text(" #{likeTopicCount} 个 赞")
      else
        span.text("")
    )
    btn.removeClass('active')
  else
    $.post("/topics/#{topicId}/like", (data) ->
      likeTopicCount = data.data
      if data.data > 0
        span.text(" #{likeTopicCount} 个 赞")
      else
        span.text("")
    )
    btn.addClass('active')
  return false
