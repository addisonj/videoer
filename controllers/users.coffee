{sendJSON, send, ok} = require "../lib/express/helpers"
crypto = require "crypto"

module.exports = (User, security_salt, winston) ->
  login: (req, res) ->
    User.find {username: req.body.username}, (err, users) ->
      shasum = crypto.createHash "sha256"
      shasum.update req.body.password
      shasum.update security_salt
      password = shasum.digest("hex")
      for user in users
        return res.redirect("/videos") if user.password == password

      res.redirect "/login"
