//= require jquery
//= require jquery_ujs

var submenuItems = document.querySelectorAll(".submenu_item");
var main   = document.querySelector(".admin-main");
var sidebar = document.querySelector(".sidebar");


// toggle sidebar
$("#sidebarOpen").click( () => {
  $(".sidebar").toggleClass("close");
});


// show submenu
$(".submenu_item").click(function() {
  $(this).toggleClass("show_submenu");  
  $(".submenu_item").not(this).removeClass("show_submenu");
});



/* functions to alter display property according to screen size */
function adjust_lg(){

    sidebar.classList.remove("close");
    main.classList.remove("main-expand");
}

function adjust_md_sm(){

    sidebar.classList.add("close");
    main.classList.add("main-expand");
}

$(document).ready(function() {
    // Check window width on page load
    // if ($(window).width() < 768) {
    //     adjust_md_sm();
    // }
  
    // Check window width on window resize
    $(window).resize(function() {
      if ($(window).width() < 768) {
        adjust_md_sm();
      } else {
        adjust_lg();
      }
    });
  });

  