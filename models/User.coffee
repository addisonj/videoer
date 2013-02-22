mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

module.exports = User = (db) ->

  UserSchema = new Schema {

    # The name of the user
    name: type: String, required: true

    # The name of the user
    username: type: String, required: true

    # The name of the user
    password: type: String, required: true
  }

  User = db.model "User", UserSchema
