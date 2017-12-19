#= require jquery3
#= require jquery_ujs
#= require turbolinks
#= require popper
#= require bootstrap-sprockets
#= require topics
#= require_self
#= require jquery.atwho

window.App =
  alert : (msg,to) ->
    $(".alert").remove()
    $(to).before("<div class='alert alert-warning'><a class='close' href='#' data-dismiss='alert'><i class='fa fa-close'></i></a>#{msg}</div>")

$(document).on 'ajax:error', '#new_user', (event, xhr, status, error) ->
                                            App.alert(xhr.responseText, '#main')
