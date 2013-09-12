# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('form#gear-search input').on('keypress', ->

  # timeout to give the DOM time to catch up 
  # with text field update
  setTimeout(loadGear, 50)
)


loadGear = -> 
  search = $('form#gear-search input#search').val()
  if search == ''
    $('#gear-results').html('')
  else
    $.ajax({
      url: '/search_suggestions',
      data: 'search=' + search,
      dataType: 'script'
    })

