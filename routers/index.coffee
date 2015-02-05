express = require "express"
router = express.Router()
jade = require "jade"
fs = require "fs"

pwd = process.env.PWD

renderTemplate = (page) ->
    return jade.renderFile pwd + "/views/templates/#{page}.jade"

templateExist = (page) ->
    return fs.existsSync pwd + "/views/templates/#{page}.jade"

router
    .get "/", (req, res) ->
        res.render "index",
            views: renderTemplate
            page: "main"
            title: "Main"
    .get "/:page", (req, res) ->
        if req.params.page is "main" or not templateExist req.params.page
            return res.redirect "/"

        switch req.params.page
            when "tab2"
                title = "Tab 2"
            when "tab3"
                title = "Tab 3"

        res.render "index",
            views: renderTemplate
            page: req.params.page
            title: title

module.exports = router