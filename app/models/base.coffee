import DS from 'ember-data'

Base = BaseModel.extend

  createdAt: DS.attr 'date'
  updatedAt: DS.attr 'date'
  deletedAt: DS.attr 'date'

export default Base
