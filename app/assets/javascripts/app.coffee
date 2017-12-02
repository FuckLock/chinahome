# @Author: baodongdong
# @Date:   2017-11-19T09:52:24+08:00
# @Last modified by:   baodongdong
# @Last modified time: 2017-11-19T19:06:43+08:00

#= require jquery3
#= require jquery_ujs
#= require turbolinks
#= require popper
#= require bootstrap-sprockets

window.App =
  alert : (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert alert-warning'><a class='close' href='#' data-dismiss='alert'><i class='fa fa-close'></i></a>#{msg}</div>")

$(document).on 'ajax:error', '#new_user', (event, xhr, status, error) ->
                                            App.alert(xhr.responseText, '#main')
