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

function dice(number, options) {
  options = options || {rerollIf: function(result) { return false }}
  var result = parseInt(Math.random() * number) + 1
  if(options.rerollIf(result)) result = dice(number, options)
  return result
}

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

Array.prototype.shuffle = function() {
  var i = this.length, j, temp
  if ( i == 0 ) return this
  while ( --i ) {
     j = Math.floor( Math.random() * ( i + 1 ) )
     temp = this[i]
     this[i] = this[j]
     this[j] = temp
  }
  return this
}

Array.prototype.first = function() {
  return this[0]
}

Array.prototype.last = function() {
  return this[this.length-1]
}

Array.prototype.isEmpty = function() {
  return this.length == 0
}

String.prototype.capitalize = function() {
  return this.charAt(0).toUpperCase() + this.slice(1)
}

String.prototype.toI = function() {
  return parseInt(this) || 0
}

String.prototype.include = function(substring) {
  return this.indexOf(substring) >= 0
}

Number.prototype.isEven = function() {
  return this % 2 == 0
}

Number.prototype.isOdd = function() {
  return this % 2 == 1
}

Number.prototype.times = function(callback) {
  for(var i=0; i<this; i++) {
    callback(i)
  }
}

$(function() {
  $("textarea").autosize()
  $(".fancy").fancybox()
})
