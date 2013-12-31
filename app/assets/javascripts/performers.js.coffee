jQuery ->
  $("#genre-select").selectize({
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
