# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # enable chosen js
  $('.chosen-select').chosen
    max_selected_options: 5
    display_selected_options: true
    no_results_text: 'No results matched'
    width: '100%'