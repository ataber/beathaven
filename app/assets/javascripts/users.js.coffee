$("#user-edit-tab").ready ->
  $(@).on "click", "a", (event) ->
    event.preventDefault()
    href = $(@).attr("href")
    $('#user-edit-tab a[href="#{href}"]').tab("show")
