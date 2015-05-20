// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){

  // default setting of play button visibility
  $(".play").hide();
  $(".newGame").hide();

  // call namespaced functions
  function setHandlers(){
    app.bouncyBalls();

  };

  setHandlers();


  $(function(){

    var app = app || {};
    app.movieTemplateNode = $('#movie-template');
    app.movieTemplate = _.template( app.movieTemplateNode.html() );


    $('#movie_search').on('keyup', function(){
      $( "#container" ).hide(700);

      var field = $(this);

      $.ajax({
        method: 'get',
        url: '/api/movies',
        data: {t: field.val()},
        success: function(data){
          console.log(data)
          if (data.movie){
            var movieHTML = app.movieTemplate( data.movie );
            $('#movie-display').html( movieHTML );
            app.movieID = data.movie.id;
          }
        }
      });

    });

  });

});
