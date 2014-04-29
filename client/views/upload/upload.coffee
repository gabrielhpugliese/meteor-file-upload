###
 Upload: Event Handlers and Helpers
###
Template.Upload.events
  'change input': (ev) ->
    _.each ev.target.files, (file) ->
      Meteor.saveFile file, file.name
###
Example: 
 'click .selector': (e, tmpl) ->
### 


Template.Upload.helpers {}
###
Example: 
 items: ->
   Items.find()
###

###
 Upload: Lifecycle Hooks
###
Template.Upload.created = ->

Template.Upload.rendered = ->

Template.Upload.destroyed = ->

Meteor.saveFile = (blob, name, path, type, callback) ->
  fileReader = new FileReader()
  method = undefined
  encoding = "binary"
  type = type or "binary"
  switch type
    when "text"
      # TODO Is this needed? If we're uploading content from file, yes, but if it's from an input/textarea I think not...
      method = "readAsText"
      encoding = "utf8"
    when "binary"
      method = "readAsBinaryString"
      encoding = "binary"
    else
      method = "readAsBinaryString"
      encoding = "binary"
  fileReader.onload = (file) ->
    Meteor.call "saveFile", file.srcElement.result, name, path, encoding, (err, res) ->
      console.log err, res

  fileReader[method] blob
