$(".flash").ready ->
  hideFlash = ->
    $(".flash").hide(500)
  setTimeout(hideFlash, 2000)
