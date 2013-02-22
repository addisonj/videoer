{clone, extend} = require 'underscore'
{curry} = require 'fjs'

# creates a callback function that send either the error or the data
exports.send = (res) ->
  (err, data) ->
    # console.log "ERR", err, Object.keys(err)
    if err? then return sendError res, err
    return res.send 404 if not data?
    res.send data

exports.sendError = sendError = (res, err) ->
  errorObject = extend {message: err.message}, err
  return res.send errorObject, 500

exports.ok = (res) ->
  (err) ->
    if err? then return sendError res, err
    res.send 200

exports.sendJSON = (res) ->
  (err, data) ->
    if err? then return sendError res, err
    return res.send 404 if not data?
    res.json data
