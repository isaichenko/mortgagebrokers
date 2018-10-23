$(document).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip()
  $(function() {
    return $('.chosen-select-lang').chosen({
      max_selected_options: 5,
      display_selected_options: true,
      no_results_text: 'No results matched',
      width: '100%'
    });
  });
});