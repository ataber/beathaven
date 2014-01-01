$ ->
  $(".col-sm-4#genre-select").append('<select style="width: 100%;" type="select" id="genre-select"></select>')
  $("select#genre-select").selectize({
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
