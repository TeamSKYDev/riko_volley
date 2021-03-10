var $win = $(window);

$win.on('load resize', function() {
  var windowWidth = window.innerWidth;

  if (windowWidth < 768) {
    $('.d-flex.changeable').removeClass('justify-content-between');
    $('.d-flex.changeable').addClass('flex-column');
    $('#notification .col-8.changeable').removeClass('col-8');
    $('.btn').addClass('btn-sm');
  }else{
    $('.d-flex.changeable').removeClass('flex-column');
    $('.d-flex.changeable').addClass('justify-content-between');
    $('#notification .col-8.changeable').addClass('col-8');
    $('.btn').removeClass('btn-sm');
  }
});
