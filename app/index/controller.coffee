import Ember from 'ember'

IndexController = Ember.Controller.extend

  isLoading: false

  publicAPI: null
  lat: 37.0902
  lng: -95.7129
  zoom: 4
  mapStyle: {}

  marker: null
  markers: Em.A([{
    name: 'Oklahoma'
    lat: 35.459510735
    lng: -96.767587499
    thumbnail: "/assets/images/building-1.jpeg"
  },{
    name: 'Florida'
    lat: 28.070724533
    lng: -81.738290624
    thumbnail: "/assets/images/building-2.jpeg"
  },{
    name: 'Mexico'
    lat: 23.88453639
    lng: -103.00782187
    thumbnail: "/assets/images/building-3.jpeg"
  }])

  location: null

  promptAddLocation: (lat, lng, latLng) ->
    i = @get('markers.length') % 3 + 1
    @set('location', {
      name: ''
      lat: lat
      lng: lng,
      latLng: latLng
      thumbnail: "/assets/images/building-#{i}.jpeg"
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
