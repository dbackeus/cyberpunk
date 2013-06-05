// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_directory .

Array.prototype.sample = function() {
  return this[Math.floor((Math.random()*this.length))]
}

Array.prototype.popHighestValue = function() {
  var highest = Math.max.apply(Math, this)
  return this.deleteOne(highest)
}

Array.prototype.deleteOne = function(matcher) {
  for(var i=0; i<this.length; i++) {
    var value = this[i]
    if(value == matcher) {
      this.splice(i, 1)
      return value
    }
  }
}

Array.prototype.isEmpty = function() {
  return this.length == 0
}

String.prototype.capitalize = function() {
  return this.charAt(0).toUpperCase() + this.slice(1)
}

Number.prototype.isEven = function() {
  return this % 2 == 0
}

Number.prototype.isOdd = function() {
  return this % 2 == 1
}

String.prototype.toI = function() {
  return parseInt(this) || 0
}

$(function() {
  $("textarea").autosize()
})
