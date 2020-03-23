'use strict'

const Router = require('express').Router

const config = require('../config')
const logger = require('../logger')
const response = require('../response')

const uploader = require('multer')({ dest: config.uploadsPath })

const imageRouter = module.exports = Router()

// upload image
imageRouter.post('/uploadimage', uploader.single('image'), function (req, res) {
  if (!req.file || !req.file.path) {
    response.errorForbidden(res)
  } else {
    if (config.debug) {
      logger.info('SERVER received uploadimage: ' + JSON.stringify(req.file))
    }

    const uploadProvider = require('./' + config.imageUploadType)
    uploadProvider.uploadImage(req.file.path, function (err, url) {
      if (err !== null) {
        logger.error(err)
        return res.status(500).end('upload image error')
      }
      res.send({
        link: url
      })
    })
  }
})
