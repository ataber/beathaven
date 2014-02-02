$(".comments").ready ->
  $(@).on "ajax:success", "form#comment-form", (event, data) ->
    $(".comments-wrapper").append(data.html)
    $(@).val("")
