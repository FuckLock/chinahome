#= require jquery3
#= require jquery_ujs
#= require turbolinks
#= require popper
#= require bootstrap-sprockets
#= require topics
#= require_self
#= require jquery.atwho
#= require form_storage

class App
  isLogined: ->
    document.getElementsByName('current-user').length > 0
    
  alert : (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert alert-warning'><a class='close' href='#' data-dismiss='alert'><i class='fa fa-close'></i></a>#{msg}</div>")

app = new App()

$(document).on 'ajax:error', '#new_user', (event, xhr, status, error) ->
  app.alert(xhr.responseText, '#main')

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
  if !app.isLogined()
    location.href = '/account/sign_in'
    return false
  btn = $(e.currentTarget)
  topicId = btn.data('id')
  span = btn.find("span")
  popover = $('[data-toggle="popover"]')
  popover.popover('hide')
  if btn.hasClass("active")
    $.post("/topics/#{topicId}/unlike", (data) ->
      data = data.data
      likeTopicCount = data.like_users_count
      popover.attr('data-content', data.like_users)
      if  likeTopicCount > 0
        span.text(" #{likeTopicCount} 个 赞")
      else
        span.text("")
    )
    btn.removeClass('active')
  else
    $.post("/topics/#{topicId}/like", (data) ->
      data = data.data
      likeTopicCount = data.like_users_count
      popover.attr('data-content', data.like_users)
      if likeTopicCount > 0
        span.text(" #{likeTopicCount} 个 赞")
      else
        span.text("")
    )
    btn.addClass('active')
  return false
