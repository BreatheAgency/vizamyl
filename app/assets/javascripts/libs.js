//= require jquery

$(document).ready(function () {
  $(".header__bar , .offcanvas-overlay").click(function () {
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
