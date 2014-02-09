$("#user-edit-tab").ready ->
  $(@).on "click", "#user-edit-tab a", (event) ->
    event.preventDefault()
    href = $(@).attr("href")
    $('#user-edit-tab a[href="#{href}"]').tab("show")
