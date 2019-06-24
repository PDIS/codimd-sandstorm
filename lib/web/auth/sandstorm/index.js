'use strict'

const Router = require('express').Router
const passport = require('passport')
const CustomStrategy = require('passport-custom')
const config = require('../../../config')
const models = require('../../../models')
const logger = require('../../../logger')
const response = require('../../../response')
const { setReturnToFromReferer } = require('../utils')
let sandstormAuth = (module.exports = Router())

const profileStringify = header => JSON.stringify({
  id: header['x-sandstorm-user-id'],
  displayName: decodeURIComponent(header['x-sandstorm-username']),
  photo: header['x-sandstorm-user-picture'],
  provider: 'sandstorm',
  _raw: JSON.stringify(header),
  _json: header
})

passport.use(
  'sandstorm-header',
  new CustomStrategy(function (req, done) {
    const header = Object.keys(req.headers)
      .filter(key => /x-sandstorm-/.test(key))
      .reduce((carry, key) => {
        let target = {}
        target[key] = req.header(key)
        return Object.assign(target, carry)
      }, {})

    const stringifiedProfile = profileStringify(header)

    models.User.findOrCreate({
      where: {
        profileid: header['x-sandstorm-user-id']
      },
      defaults: {
        profile: stringifiedProfile
      }
    })
      .spread(function (user, created) {
        if (user) {
          var needSave = false
          if (user.profile !== stringifiedProfile) {
            user.profile = stringifiedProfile
            needSave = true
          }

          if (needSave) {
            user.save().then(function () {
              if (config.debug) {
                logger.info('user login: ' + user.id)
              }
              return done(null, user)
            })
          } else {
            if (config.debug) {
              logger.info('user login: ' + user.id)
            }
            return done(null, user)
          }
        }
      })
      .catch(function (err) {
        logger.error('auth callback failed: ' + err)
        return done(err, null)
      })
  })
)

sandstormAuth.get('/auth/sandstorm', function (req, res, next) {
  const header = Object.keys(req.headers).filter(key =>
    /x-sandstorm-/.test(key)
  ).reduce((carry, key) => {
    let target = {}
    target[key] = req.header(key)
    return Object.assign(target, carry)
  }, {})

  if (!header['x-sandstorm-user-id']) {
    return response.errorBadRequest(res)
  }
  setReturnToFromReferer(req)
  passport.authenticate('sandstorm-header', {
    successReturnToOrRedirect: '/',
    failureRedirect: '/',
    failureFlash: true
  })(req, res, next)
})
