express = require "express"
fs = require "fs"

pwd = __dirname

app = express()

app.set "views", pwd + "/views"
app.set "view engine", "jade"

app.use express.static pwd + "/public"

app.use "/", require pwd + "/routers/index"

for file in fs.readdirSync pwd + "/routers" when file isnt "index.coffee"
    app.use "/" + file.slice(0, -7), require(pwd + "/routers/" + file)

module.exports = app