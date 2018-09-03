import DS from 'ember-data'
import config from 'ember-get-config'
import HasManyQuery from 'ember-data-has-many-query'

BaseAdapter = DS.JSONAPIAdapter.extend  HasManyQuery.RESTAdapterMixin,

  host: config.host
  namespace: config.namespace

export default BaseAdapter
