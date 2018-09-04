import Ember from 'ember'

IndexController = Ember.Controller.extend

  isLoading: false

  publicAPI: null
  lat: 37.0902
  lng: -95.7129
  zoom: 4
  mapStyle: {}

  map: Ember.computed 'publicAPI.map', ->
    @get('publicAPI.map')

  selectedLocation: null
  newLocation: null
  locations: Em.A()

  promptAddLocation: (latLng) ->
    i = @get('locations.length') % 3 + 1
    @set('newLocation', {
      name: ''
      lat: latLng.lat()
      lng: latLng.lng()
      latLng: latLng
      thumbnail: "/assets/images/building-#{i}.jpeg"
    })
    @set('isAddingLocation', true)

  cancelAddLocation: ->
    @set('newLocation', null)
    @set('isAddingLocation', false)

  submitLocation: ->
    @set('isAddingLocation', false)
    location = @get('newLocation')
    last = @get('locations.lastObject')
    @get('locations').addObject(location)
    if last
      @addCurve(location, last)

  addCurve: (marker1, marker2) ->
    curvature = 0.5
    map = @get('map')
    p1 = marker1.point
    p2 = marker2.point

    projection = map.getProjection()
    p1 = projection.fromLatLngToPoint(marker1.latLng)
    p2 = projection.fromLatLngToPoint(marker2.latLng)

    e = new google.maps.Point(p2.x - p1.x, p2.y - p1.y) # endpoint (p2 relative to p1)
    m = new google.maps.Point(e.x / 2, e.y / 2) # midpoint
    o = new google.maps.Point(e.y, -e.x) # orthogonal
    c = new google.maps.Point(m.x + curvature * o.x, m.y + curvature * o.y) # curve control point

    pathDef = 'M 0,0 ' + 'q ' + c.x + ',' + c.y + ' ' + e.x + ',' + e.y

    zoom = map.getZoom()
    scale = 1 / (Math.pow(2, -zoom))
    
    curveMarker = new google.maps.Marker
        position:
          lat: marker1.lat
          lng: marker1.lng
        clickable: false
        icon:
          path: pathDef
          scale: scale
          strokeWeight: 2
          fillColor: 'none'
        zIndex: 0
        map: map


  actions:

    onLoad: (publicAPI) ->
      @set('publicAPI', publicAPI)

    hover: (m, e) ->
      Ember.set(m, 'isOpen', true)
      @set('selectedLocation', m)

    leave: (m, e) ->
      Ember.set(m, 'isOpen', false)
      @set('selectedLocation', null)

    clickedMap: (e) ->
      ge = e.googleEvent
      @promptAddLocation(ge.latLng)

    cancelAddLocation: ->
      @cancelAddLocation()

    submitLocation: ->
      @submitLocation()

export default IndexController
