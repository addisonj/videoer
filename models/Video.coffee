mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

module.exports = Video = (db) ->

  VideoSchema = new Schema {

    # The name of the video
    name: type: String, required: true

    # The name of the video
    rating: type: String, required: true

    # The name of the video
    length: type: Number, required: false
  }

  Video = db.model "Video", VideoSchema
