$(document).ready(function (){
  $('.js-focus').focus();

  $("#js-average-salary input[type='submit']").on("click", function(event){
    if(!$('input#title').val()){
      $('#error-modal .modal-body p').html("Please provide a valid string input. Ex. 'teacher'");
      $('#error-modal').modal();
      event.preventDefault();
    }
  });
});