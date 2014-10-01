TextWidget = require './text-widget'
labels = require '../notes'
Geocoder = require '../geocoder'
translate = require 't7e'

class PlaceWidget extends TextWidget
  template: require '../../views/tools/place'
  
  type: 'place'
  help: '/diary/place'
  
  gc: new Geocoder
  
  updateNote: (target)->
    
    @el
      .find('.suggestions')
      .html('')
      .removeClass 'open'
    
    placename = @el.find('input[name=place]').val()
    
    @gc.geocode( placename )
      .pipe( (places) =>
        @choose_place places
      )
      .progress( (place)=>
        console?.log place
        @update_place place
      )
      .done (place)=>
        @update_place place
      
        
    note = @update_notes()
    console?.log note
    note
  
  update_notes: =>
    note =
      place: ''
      lat: ''
      long: ''
      location: false
      name: ''
      id: ''
      
    $inputs = @el.find( '.annotation :input' )
      
    $inputs
      .each ->
        note[@name] = @value
      
    note.location = 
      $inputs
        .filter('input[name=location]')
        .is(':checked')
    
    note
  
  update_place: (place) =>
    {lat, long, name, id} = place
  
    @el
      .find( 'input[name=lat]' )
      .val( lat )
      .end()
      .find( 'input[name=long]' )
      .val( long )
      .end()
      .find( 'input[name=name]')
      .val( name )
      .end()
      .find( 'input[name=id]')
      .val( id )
    
    placename = @el.find('input[name=place]').val()
  
    @show_place lat, long
    
  getLabel: (target) ->
    $(target)
      .parents('.annotation')
      .find('input[name=place]')
      .val()
  
  render: (el)->
    super
    return unless google? && google.maps?
    try
      map_options =
        zoom: 9
        mapTypeId: google.maps.MapTypeId.TERRAIN
        mapTypeControl: false
        zoomControl: true,
        zoomControlOptions:
          style: google.maps.ZoomControlStyle.SMALL
          position: google.maps.ControlPosition.LEFT_TOP
          
      @gmap = new google.maps.Map $('.map', @el)[0], map_options
      lat = el.find( 'input[name=lat]' ).val()
      long = el.find( 'input[name=long]' ).val()
    
      @show_place( lat, long )
    catch e
      console?.log e.message

  show_place: (lat, long) =>
    return unless google? && google.maps?
    try
      latlng = new google.maps.LatLng lat,long
      @marker?= new google.maps.Marker 
        position: latlng
        map: @gmap
        bounds: false
      @marker.setPosition latlng
      google.maps.event.trigger @gmap, 'resize'
      @gmap.setCenter latlng
    catch e
      console?.log e.message
    
    $suggestions = @el.find '.suggestions'
    $checked = $suggestions.find('input:checked').focus()
    $suggestions.scrollTop $checked.position().top
  
  choose_place: (places) =>
    promise = new $.Deferred
    
    
    $suggestions = @el.find '.suggestions'
    $placename = @el.find('input[name=place]')
    $id = @el.find('input[name=id]')
    
    group_id = $suggestions.uniqueId().attr 'id'
    
    console?.log $id.val()
    
    selected = false
    nowhere =
      placename: @el.find('input[name=place]').val()
      lat: null
      long: null
      name: ''
      id: ''
    
    choose_option = (e) ->
      place = e.data
      e.preventDefault()
      e.stopPropagation()
      promise.notify place
      $suggestions.find('label').off 'mouseover focus'
      $placename.trigger 'change'
    
    show_option = (e) =>
      place = e.data
      @show_place place.lat, place.long
    
    select = (input, place) =>
      input.attr('checked', 'checked').prop 'checked', true 
      @show_place place.lat, place.long
      promise.notify place
      selected = true
      
    build_input = (label, place) =>
      label = $("<label>#{label}</label>")
      input = 
        $("<input/>")
        .attr( "type", 'radio' )
        .attr( 'name', group_id)
        .on 'change', place, choose_option
        
      label.prepend input
      label.on 'mouseover focus', place, show_option
        
      $suggestions.append label
      select input, place if place.id == $id.val()
      
      input
      
    not_sure = build_input translate('span', 'classifier.place.none'), nowhere    
    build_input "<span>#{place.name}</span>", place for place in places
      
    $suggestions.addClass 'open'
    $suggestions.find('label').off 'mouseover focus' if selected
    select not_sure, nowhere unless selected
    
    promise

module.exports = PlaceWidget
