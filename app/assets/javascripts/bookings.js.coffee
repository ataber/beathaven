$("#pending-bookings").ready ->
  $(@).on "click", ".decline-link", (event) ->
    $(@).parents("tr").hide()
