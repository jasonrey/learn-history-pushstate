express = require "express"
router = express.Router()
fs = require "fs"

pwd = process.env.PWD

router.get "/:page", (req, res) ->
    file = "#{pwd}/views/templates/#{req.params.page}.jade"

    unless fs.existsSync file
        return res.render "error"

    res.render "templates/#{req.params.page}"

module.exports = router