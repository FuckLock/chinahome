#= require jquery3
#= require jquery_ujs
#= require turbolinks
#= require popper
#= require bootstrap-sprockets
#= require topics
#= require_self
#= require jquery.atwho
#= require form_storage
#= require social-share-button
#= require social-share-button/wechat
#= require rails-timeago
#= require timeago-zh-CN

class App
  isLogined: ->
    document.getElementsByName('current-user').length > 0

  alert: (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert alert-warning'><a class='close' href='#' data-dismiss='alert'><i class='fa fa-close'></i></a>#{msg}</div>")

  setReplyId: (id) ->
    $('input[name="reply[reply_to_id]"]').val(id)

app = new App()

window.App =
  scanMentionableLogins: (query) ->
    logins = []
    for e in query
      $e = $(e)
      item =
        login      : $e.find(".btn-reply").first().data('login')
        name       : $e.find(".btn-reply").first().data('name')
        avatar_url : $e.find(".media-object").first().attr("src")

      continue if not item.login
      continue if not item.name

      logins.push(item)

    logins = window.App.unique(logins)
    return logins

  mentionable : (el, logins) ->
    logins = [] if !logins
    $(el).atwho
      at         : "@"
      limit      : 8
      callbacks  :
        remoteFilter: (query, callback) ->
          $.getJSON '/search/users.json', { q: query }, (data) ->
            for login in logins
              data.unshift(login)

            data = window.App.unique(data)
            callback(data)
      displayTpl : "<li><img src=${avatar_url} class='avatar-16'/> ${login} <small>${name}</small></li>"
      insertTpl  : "@${login}"

  unique : (data) ->
    res = []
    json = {}
    for login in data
     if(!json[login.login])
      res.push(login)
      json[login.login] = true
    return res



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

$(document).on 'click', '.button-topic-heart', (e) ->
  if !app.isLogined()
    location.href = '/account/sign_in'
    return false
  btn = $(e.currentTarget)
  topicId = btn.data('id')
  span = $('.button-topic-heart').find("span")
  popover = $('[data-toggle="popover"]').popover('hide')
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
    $('.button-topic-heart').removeClass('active')
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
    $('.button-topic-heart').addClass('active')
  return false

$(document).on 'click', '.button-collect', (e) ->
  if !app.isLogined()
    location.href = '/account/sign_in'
    return false
  btn = $(e.currentTarget)
  topicId = btn.data('id')
  if btn.hasClass('active')
    $.post("/topics/#{topicId}/uncollect")
    $('.button-collect').removeClass('active')
  else
    $.post("/topics/#{topicId}/collect")
    $('.button-collect').addClass('active')
  return false

$(document).on 'click', '.button-reply-heart', (e) ->
  if !app.isLogined()
    location.href = '/account/sign_in'
    return false
  btn = $(e.currentTarget)
  replyId = btn.data('id')
  span = btn.find("span")
  popover = $('[data-toggle="popover"]').popover('hide')
  if btn.hasClass("active")
    $.post("/replies/#{replyId}/unlike", (data) ->
      data = data.data
      likeReplyCount = data.like_users_count
      popover.attr('data-content', data.like_users)
      if  likeReplyCount > 0
        span.text(" #{likeReplyCount} 个 赞")
      else
        span.text("")
    )
    btn.removeClass('active')
  else
    $.post("/replies/#{replyId}/like", (data) ->
      data = data.data
      likeReplyCount = data.like_users_count
      popover.attr('data-content', data.like_users)
      if likeReplyCount > 0
        span.text(" #{likeReplyCount} 个 赞")
      else
        span.text("")
    )
    btn.addClass('active')
  return false

$(document).on 'click', '.btn-reply', (e) ->
  if !app.isLogined()
    location.href = '/account/sign_in'
    return false
  $(".alert-user").remove()
  btn = $(e.currentTarget)
  replyToId = btn.data('id')
  user = btn.data('login')
  $(".preview").after('<a class="alert alert-info alert-dismissible fade show alert-user" role="alert" href="/' + user + '"' + '>' +
                      '<i class="fa fa-mail-reply" title="回复"></i>' + '  ' +
                      user +
                      '<button type="button" class="close-button" data-dismiss="alert" aria-label="Close">' +
                      '<span aria-hidden="true">&times;</span>' +
                      '</button>' +
                      '</a>'
                      )
  app.setReplyId(replyToId)
  return false

$(document).on 'click', '.close-button', () ->
  $('input[name="reply[reply_to_id]"]').val("")

$(document).on 'click', '.btn-reply-to-id', (e) ->
  btn = $(e.currentTarget)
  replyBody = btn.parent().next()
  if replyBody.css("display") == "none"
    replyBody.css("display", "block")
  else
    replyBody.css("display", "none")
  return false
