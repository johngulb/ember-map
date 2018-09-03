import DS from 'ember-data'
import BaseModel from '../models/base'
import { modelAction } from 'ember-custom-actions'

<%= modelName %> = BaseModel.extend

  name: DS.attr 'string'

export default <%= modelName %>
