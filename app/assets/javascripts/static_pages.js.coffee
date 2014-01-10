# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

showWordCount = ->
  micropost = $('#micropost_content').val()
  $('div.stats').text "Remaining characters: #{140 - micropost.length}"

$(document).ready ->
  
  $("textarea#micropost_content").on "keydown", () => 
    showWordCount();
