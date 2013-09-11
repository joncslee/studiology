# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('form#gear-search input').on('keypress', ->
  setTimeout(loadGear, 50)
)

loadGear = -> 
  $.ajax({
    url: '/search_suggestions',
    data: 'search=' + $('form#gear-search input#search').val(),
    dataType: 'script'
  })

