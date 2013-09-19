# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#
# autocompletion trigger
#
$('form#gear-search input').on('keypress', ->

  # timeout to give the DOM time to catch up 
  # with text field update
  setTimeout(loadGear, 50)
)

#
# gear adding and deleting
#
$('#gear-results').on('click', 'a.add-gear', ->
   gearId = this.getAttribute('data-id')
   updateGear(gearId, 'add')
)
$('#gear-results').on('mouseenter mouseleave', '.gear-result', (e) ->
  if e.type == 'mouseenter' 
    $(this).addClass('highlighted')
    $(this).find('a.add-gear').show()
  else if e.type == 'mouseleave'
    $(this).removeClass('highlighted')
    $(this).find('a.add-gear').hide()
)

# 
# row highlighting on hover
#
$('#gear-ownership').on('click', 'a.remove-gear', ->
   gearId = this.getAttribute('data-id')
   updateGear(gearId, 'remove')
)
$('#gear-ownership').on('mouseenter mouseleave', 'tr', ->
  $(this).find('a.remove-gear').toggle()
)

#
# pinterest-style dynamic tiling for studio page
#
container = $('#gear-container')
container.imagesLoaded( ->
  # alter long image dimensions if necessary
  $('#gear-container a.item').each( ->
    anchor = this
    $(anchor).find('img').each( ->
      width = this.width
      height = this.height
      if width > 2 * height
         $(anchor).addClass('wide')
      else if height > 2 * width
         $(anchor).addClass('narrow')
    )
  )
  container.show()
  container.masonry({
    columnWidth: 50,
    itemSelector: 'a.item'
  })
)

#
# ajax methods
#
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

updateGear = (gearId, aod) ->
  $.ajax({
    url: '/update_gear',
    data: 'gear_id=' + gearId + '&aod=' + aod,
    dataType: 'script'
  })
