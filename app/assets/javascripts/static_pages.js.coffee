# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

showWordCount = ->
  micropost = $('#micropost_content').val()
  alert "140 - #{micropost.length}"

$("body").on "click", () => 
  showWordCount();

