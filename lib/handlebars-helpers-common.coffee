_ = require 'lodash'
moment = require 'moment'
moment.lang('fr')

module.exports =
  helpers:
    escape: (content) ->
      console.log("escape "+_.escape(content))
      _.escape(content)
    parseJSON: (content,options) ->
      options.fn(JSON.parse(content) or {})
    map: (value,into,options) ->
      unless options
        options = into
        into = undefined
      mapping = options.hash
      mapped = mapping[value] or mapping.default or value
      if into
        @[into] = mapped
        output = undefined
      else
        output = mapped
    addToContext: (options) ->
      values = options.hash or {}
      for name,value in values
        @[name]=value
      options.fn(@)
    debug:(content,options) ->
      console.log('this: '+JSON.stringify(this))
      console.log('content: '+JSON.stringify(content))
      console.log('options: '+JSON.stringify(options))
      output = undefined
    debugger: -> debugger
    capitalize: (content) ->
      content.charAt(0).toUpperCase() + content.slice(1)
    formatMoment: (content,options) ->
      hash = options?.hash or {}
      fmt = hash.fmt or 'dddd'
      content.format(fmt)
    formatDate: (content,options) ->
      mapping = options?.hash or {}
      parse = mapping.parse
      fmt = mapping.fmt
      if _.isString(content)
        date = moment.utc(content,parse)
      else
        date = moment.utc(content)
      return date.format(fmt)



