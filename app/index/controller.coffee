import Ember from 'ember'

IndexController = Ember.Controller.extend

  isLoading: false

  map: null
  lat: 37.0902
  lng: -95.7129
  zoom: 4
  mapStyle: {}

  markers: Em.A([{
    name: 'Test'
    lat: 37.0902
    lng: -95.7129
    active: false
    isOpen: false
  }])

  # selectedMarker: null

  location: null

  promptAddLocation: (lat, lng) ->
    @set('location', {
      name: 'Test'
      lat: lat
      lng: lng
    })
    @set('isAddingLocation', true)

  cancelAddLocation: ->
    @set('location', null)
    @set('isAddingLocation', false)

  submitLocation: ->
    @set('isAddingLocation', false)
    @get('markers').addObject(@get('location'))

  actions:

    onLoad: (map) ->
      console.log("LOADED MAP")
      @set('map', map)

    toggle: (m, e) ->
      console.log("TOGGLE")
      Ember.set(m, 'isOpen', true)

    hover: (m, e) ->
      console.log("HOVER")
      Ember.set(m, 'isOpen', true)

    leave: (m, e) ->
      console.log("LEAVE")
      Ember.set(m, 'isOpen', false)

    clickedMap: (e) ->
      console.log("CLICKED MAP: ", e)
      ge = e.googleEvent
      @promptAddLocation(ge.latLng.lat(), ge.latLng.lng())

    cancelAddLocation: ->
      @cancelAddLocation()

    submitLocation: ->
      @submitLocation()

export default IndexController
