// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require_jquery_nested_form

/* Sets the minimum height of the wrapper div to ensure the footer reaches the bottom */
function setWrapperMinHeight() {
  $('.wrapper').css('minHeight', window.innerHeight - $('.nav').height() - $('.footer').height() - 12);
}

$(document).ready(function(){
  /* Make sure the main div gets resized on ready */
  setWrapperMinHeight();
  /* Make sure the wrapper div gets resized whenever the screen gets resized */
  window.onresize = function() {
    setWrapperMinHeight();
  }
});

/*$(document).ready(function() {
	$('.nav ul li').hover(
    function(){
        $(this).addClass('active');
        $(this).css("color","green");
    },
    function(){
        $(this).removeClass('active');
    }
  );
});*/
