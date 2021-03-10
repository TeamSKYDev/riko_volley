var $win = $(window);

$win.on('load resize', function() {
  var windowWidth = window.innerWidth;

  if (windowWidth < 768) {
    $('.d-flex.changeable').removeClass('justify-content-between');
    $('.d-flex.changeable').addClass('flex-column');
  }else{
    $('.d-flex.changeable').removeClass('flex-column');
    $('.d-flex.changeable').addClass('justify-content-between');
  }
});
