###
 Upload Methods 
###

Meteor.methods {}
###
Example:
  '/app/upload/update/email': (email) ->
    Users.update _id: this.userId, $set: 'profile.email': email
### 
