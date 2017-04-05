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
      var is_pawn_promotion = function() {
        return (draggable.data('piece-type') === 'Pawn') &&
          (y === 0 || y === 7); 
      };

      if (is_pawn_promotion()) {
        openModal('#promo-modal');
          var promoSubmitButton = $(".promo-selection-submit");
          promoSubmitButton.on('click', function() {
            var type = $('input.promo-radio[selected]').val();
            sendAJAXRequest(x, y, type);
          });
      } else { 
        sendAJAXRequest(x, y);
      }
    
      var sendAJAXRequest = function(x, y, type) {  
        $.ajax({
          type: 'PUT',
          url: urlUpdatePath,
          data: { 
            piece: { x_position: x, y_position: y }
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

//<div class="piece" data-piece-type="Pawn"></div>

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
      } 
    }
  });
}

