//= require jquery-3.7.1.min.js
//= require popper
//= require bootstrap-sprockets

$(document).ready(function () {
  $(".burger_menu , .offcanvas-overlay").click(function () {
    if($(".offcanvas-area").hasClass('active')) {
      $(".offcanvas-area , .offcanvas-overlay").removeClass("active");
    } else {
      $(".offcanvas-area , .offcanvas-overlay").addClass("active");
    }
  });
  $(".menu-close , .offcanvas-overlay").click(function () {
    $(".offcanvas-area , .offcanvas-overlay").removeClass("active");
  });
});
