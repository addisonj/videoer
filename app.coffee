express = require 'express'
http = require 'http'
path = require "path"
config = require './config'
winston = require "winston"

process.on 'uncaughtException', (err) ->
  winston.error 'uncaughtException: '
  winston.error err.stack
  #console.log err if process.env.NODE_ENV is 'test'
  throw err if process.env.NODE_ENV is 'undefined'

exports.createServer = ->

  config.resolve (cluster, users, videos, winston) ->
    app = express()

    app.configure ->
      app.set('port', process.env.PORT || 3000)
      app.set('views', __dirname + '/views')
      app.set('view engine', 'jade')
      app.use(express.favicon())
      app.use(express.bodyParser())
      app.use express.logger({stream: winston.winstonStream, format: ':remote-addr - :req[x-forwarded-for] - - [:date] ":method :url HTTP/:http-version" :status :res[content-length] :response-time' })
      app.use(express.methodOverride())
      app.use(app.router)
      app.use(require('stylus').middleware(__dirname + '/public'))
      app.use(express.static(path.join(__dirname, 'public')))

    app.configure 'development', ->
      app.use express.errorHandler()

    app.get '/', (req, res) ->
      res.redirect "/login"

    app.get '/login', (req, res) ->
      res.render 'index', {
        title : 'Home'
      }

    app.post '/login', users.login

    app.get '/videos', videos.index

    if (!cluster.isMaster or !process.env.NODE_SERVER_MODE)
      http.createServer(app).listen app.get('port'), () ->
        winston.info "Express server listening on port " + app.get('port')

    return app

exports.app = exports.createServer()
