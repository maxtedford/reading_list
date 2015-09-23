$(document).ready(function() {
  bindSubmitButton();
  bindLinkEditLinks();
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

function bindLinkEditLinks() {
  $('.link-editor').on('click', function(event) {
    event.preventDefault();
    event.stopPropagation();
    var $li = $(this).closest('li');
    var $id = $li.data().id;
    updateLink($id, $li);
  })
}

function createNewLink(url) {
  var $linkList = $('.link-list');
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

function updateLink(id, li) {
  $.ajax({
    url: '/links/' + id,
    method: 'PUT',
    data: { id: id },
    complete: function() {
      reRenderLink(li);
    }
  })
}

function reRenderLink(li) {
  if(li.parent().data().id === "unread-links"){
    $('#read-links').append(li.html());
  } else {
    $('#unread-links').append(li.html());
  }
  li.remove();
  bindLinkEditLinks();
}
