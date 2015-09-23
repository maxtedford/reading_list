$(document).ready(function() {
  bindSubmitButton();
});

function bindSubmitButton() {
  $('#submit-button').on('click', function(event) {
    event.preventDefault();
    var url = $('#link-url').val();
    postNewLink(url);
  })
}
