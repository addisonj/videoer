{sendJSON, send, ok} = require "../lib/express/helpers"

module.exports = (Video, winston) ->
  index: (req, res) ->
    Video.find {}, (err, videos) ->
      res.render 'videos/index', {
        title : 'Home'
        videos: videos
      }

  get: (req, res) -> Video.findById req.param('id'), send(res)

  save: (req, res) -> Video.save req.body, sendJSON(res)

  remove: (req, res) -> Video.remove req.param('id'), send(res)


