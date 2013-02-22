cluster = require "cluster"
http = require "http"
http.globalAgent.maxSockets = process.env.MAX_SOCKETS || 30
path = require 'path'
{container} = require 'dependable'
Mongoose = require 'mongoose'
winston = require "winston"

winston.winstonStream = {
  write: (message) -> winston.info message
}

# read our environment and set defaults
VIDEOER_DB = process.env.VIDEOER_DB || 'mongodb://localhost:27017/videoer'
PORT = process.env.VIDEOER_PORT || 3000

db = Mongoose.createConnection VIDEOER_DB
#Mongoose.set "debug", true

db.on "error", (err) ->
  winston.error "mongoose had a connection error", err
  winston.info "waiting for 5 seconds and then exiting"
  timeout = setTimeout ->
    process.exit(1)
  , 5000
  db.once "reconnected", -> clearTimeout(timeout)
# make the container
deps = container()

# REGISTER stuff

deps.register 'db', db
deps.register "VIDEOER_DB", VIDEOER_DB
deps.register "PORT", PORT

deps.register "cluster", cluster
deps.register "winston", winston

deps.register "security_salt", "UdWakiakukdarrevfapvodHeighjowdaigJinHyod^KakwimcoibNemeshEbOyhicukDircIbImnelIvjutniudaifVeGheotFap"

# cheat, and register the whole directory by basename. (will error on conflict)
deps.load path.join(__dirname, 'models')
deps.load path.join(__dirname, 'controllers')

module.exports = deps
