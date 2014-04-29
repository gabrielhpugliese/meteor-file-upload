###
 Upload Methods 
###

cleanPath = (str) ->
  str.replace(/\.\./g, "").replace(/\/+/g, "").replace(/^\/+/, "").replace /\/+$/, ""  if str

cleanName = (str) ->
  str.replace(/\.\./g, "").replace /\//g, ""

Meteor.methods
  saveFile: (blob, name, path, encoding) ->
    # Clean up the path. Remove any initial and final '/' -we prefix them-,
    # any sort of attempt to go to the parent directory '..' and any empty directories in
    # between '/////' - which may happen after removing '..'
    
    # TODO Add file existance checks, etc...
    path = cleanPath(path)
    fs = Npm.require("fs")
    name = cleanName(name or "file")
    encoding = encoding or "binary"
    chroot = Meteor.chroot or (process.env['PWD'] + '/public')
    path = chroot + ((if path then "/" + path + "/" else "/"))
    fs.writeFile path + name, blob, encoding, (err) ->
      if err
        throw (new Meteor.Error(500, "Failed to save file.", err))
      else
        console.log "The file " + name + " (" + encoding + ") was saved to " + path
      return

    return


###
Example:
  '/app/upload/update/email': (email) ->
    Users.update _id: this.userId, $set: 'profile.email': email
### 
