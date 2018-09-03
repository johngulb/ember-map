import DS from 'ember-data'
import { JSONAPISerializer } from 'ember-custom-actions'

BaseSerializer = JSONAPISerializer.extend

  attrs:
    createdAt:
      serialize: false,
      deserialize: 'records'
    updatedAt:
      serialize: false,
      deserialize: 'records'
    deletedAt:
      serialize: false,
      deserialize: 'records'

export default BaseSerialilzer
