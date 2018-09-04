import Ember from 'ember'

IndexController = Ember.Controller.extend

  isLoading: false

  publicAPI: null
  lat: 37.0902
  lng: -95.7129
  zoom: 4
  mapStyle: {}

  marker: null
  markers: Em.A()

  location: null

  promptAddLocation: (lat, lng, latLng) ->
    @set('location', {
      name: ''
      lat: lat
      lng: lng,
      latLng: latLng
    })
    @set('isAddingLocation', true)

  cancelAddLocation: ->
    @set('location', null)
    @set('isAddingLocation', false)

  submitLocation: ->
    @set('isAddingLocation', false)
    @get('markers').addObject(@get('location'))

  actions:

    onLoad: (publicAPI) ->
      console.log("LOADED MAP")
      @set('publicAPI', publicAPI)

    hover: (m, e) ->
      console.log("HOVER")
      Ember.set(m, 'isOpen', true)
      @set('marker', m)

    leave: (m, e) ->
      console.log("LEAVE")
      Ember.set(m, 'isOpen', false)
      @set('marker', null)

    clickedMap: (e) ->
      console.log("CLICKED MAP: ", e)
      ge = e.googleEvent
      @promptAddLocation(ge.latLng.lat(), ge.latLng.lng(), ge.latLng)

    cancelAddLocation: ->
      @cancelAddLocation()

    submitLocation: ->
      @submitLocation()

export default IndexController
