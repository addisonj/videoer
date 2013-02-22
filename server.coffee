clusterMaster = require "cluster-master"
process.env.NODE_SERVER_MODE = true

app = require("./app.coffee").app


clusterMaster {
  exec: "app.coffee"
  size: process.argv[2]
  env: {"NODE_SERVER_MODE": false}
  onMessage: app.workerCluster.messageHandler
}
