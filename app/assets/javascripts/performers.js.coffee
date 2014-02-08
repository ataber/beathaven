$("#performer-form").ready ->
  $("select#performer_genre").selectize({
    maxItems: 3,
    valueField: 'genre',
    labelField: 'genre',
    options: [
      { genre: 'Rock' },
      { genre: 'Jazz' },
      { genre: 'Electronic' },
      { genre: 'Hip Hop' },
      { genre: 'Experimental' }
      ],
    create: true
    })
  $(".selectize-control").width('100%')
