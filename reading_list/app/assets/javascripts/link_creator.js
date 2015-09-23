$(document).ready(function() {
  bindSubmitButton();
});

function bindSubmitButton() {
  $('#submit-button').on('click', function(event) {
    event.preventDefault();
    var $urlField = $('#link-url');
    var $url = $urlField.val();
    $urlField.val("");
    createNewLink($url);
  })
}

function createNewLink(url) {
  var $linkList = $('#link-list');
  $.ajax({
    url: '/links/',
    method: 'POST',
    data: { url: url },
    success: function() {
      $linkList.append(
        '<li><a href="' + url + '">' + url + '</a>'
        + '<br>'
        + 'unread '
        + '<a href="">Mark as read</a>'
      )
      
    }
  })
}
