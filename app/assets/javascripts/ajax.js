$( function() {
  $( ".piece" ).draggable({
    snap: ".piece-square",
    grid: [60, 60],
    containment: ".game-board",
  });

    
  $( ".piece-square" ).droppable({
    accept: ".piece",
    drop: function( event, ui ) {
      var x = $(event.target).data('x');
      var y = $(event.target).data('y');
      var urlUpdatePath = $('.ui-draggable-dragging').data('url');

      var sendAJAXRequest = function(x, y, promo_choice) {  
        $.ajax({
          type: 'PUT',
          url: urlUpdatePath,
          data: { 
            piece: { x_position: x, y_position: y }
            piece_type: promo_choice
          },
          success: function(response) {
            if(response == 'OK') {
              console.log(response);
            } else {
              alert(response);
            }
          }
        });
      };

      if (is_pawn_promotion()) {
        openModal('#promo-modal') {
          var promotionButtons = $('...')
          promotionButtons.on('click', function() {
          sendAJAXRequest(x, y, promo_choice);
        });
        } else {
          sendAJAXRequest(x, y);
        }
      };


  function openModal (modalId, callback) {
    var $modal = $(modalId);

    $modal.prop("checked", true);

      if ($modal.is(":checked")) {
        $("body").addClass("modal-open");
      } else {
        $("body").removeClass("modal-open");
      }

    $(".modal-fade-screen, .modal-close").on("click", function() {
      $(".modal-state:checked").prop("checked", false).change();
    });

    $(".modal-inner").on("click", function(e) {
      e.stopPropagation();
    });

    $('.promo-selection-submit').on('click', function() {
        callback( $('.promo-selection').val() );
    });
  } 

};
