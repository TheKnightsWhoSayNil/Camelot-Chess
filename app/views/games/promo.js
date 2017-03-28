$(document).ready(function() {

  $(".game-board td").on("click", function() {
    $this = $(this);
    var selectedPiece = $(".game-board td").hasClass("selected");

      if (selectedPiece) {
        var $piece = activePiece();

      if ($piece.data("piece-id") == $this.data("piece-id")) {
        inactivePiece( $this );
      } else {
        movePiece ($piece, $this);
      }
    }

    function activePiece() {
      return $(".game-board td.selected");
    };

    function inactivePiece($piece) {
      $piece.removeClass("selected");
    };

    function movePiece ($piece, $square) {
      var piece = {
        id: $piece.data('piece-id'),
        x_position: $square.data("x-position"),
        y_position: $square.data("y-position")
      };

      if (promote($piece, piece.y_position)) {
        openModal("#promotion-modal", function(pieceType) {
          piece_type = pieceType;  // Is piece_type right?
          updatePiece(piece);
        });
      } else {
        updatePiece(piece);
      }
    }

    function updatePiece(piece) {
      $.ajax({
        type: "PATCH",
        url: "/games/pieces/" + piece.id,  // Is this right?
        dataType: "json",
        data: {
          piece: piece
        },
        success: function(data) {
          $(location).attr("href", data.update_url);  // Not fully understanding this line.
        }
      });
    }

    function isPawn($piece) {
      return ($piece.data("piece_type") == "Pawn");
    }

    function isPromotable(y) {
      return ((y == 0) || (y == 7));
    }

    function promote( $piece, y) {
      return (isPawn($piece) && isPromotable(y));
    }
  });

  // Modal - see games/show - I think this is set up with the correct classes??

  $(function() {
    $("#promotion-modal").on("change", function() {
      if ($(this).is(":checked")) {
        $("body").addClass("modal-open");
      } else {
        $("body").removeClass("modal-open");
      }
    });

    $(".modal-fade-screen, .modal-close").on("click", function() {
      $(".modal-state:checked").prop("checked", false).change();
    });

    $(".modal-inner").on("click", function(e) {
      e.stopPropagation();
    });

    $(".submit-promo-choice input").on("click", function() {
      callback( $('.select-promo-choice input').val() );
    });
  });
});