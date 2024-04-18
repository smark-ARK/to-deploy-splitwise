$(document).ready(function() {

  function updateResultFields() {
    console.log("hello")
    var totalAmount = parseFloat($('#amount').val());
    var splitType = $('#expense_split_type').val();

    $('.participant-amount').each(function() {
      var participantAmount = parseFloat($(this).val());
      var resultField = $(this).closest('tr').find('.participant-result');
      var no_participants = $('#expense_participant_ids').val().length
      console.log(totalAmount/no_participants, splitType)
      if (splitType === 'Equally') {
        resultField.val((totalAmount / no_participants).toFixed(2));
      } else if (splitType === 'by_percentage') {
        resultField.val((participantAmount / 100 * totalAmount).toFixed(2));
      } else if (splitType === 'by_amount') {
        resultField.val(participantAmount.toFixed(2));
      }
    });
  }
    // Event listener for participant selection
    $('#expense_participant_ids').change(function() {
      var selectedParticipants = $(this).val();
      $('#dynamic-fields').empty();
  
      // Create new fields for each selected participant
      $.each(selectedParticipants, function(index, participant) {
        var row = $('<tr>');
        var nameCell = $('<td>').text(participant);
        var inputCell = $('<td>').append($('<input>').attr({
        type: 'number',
        name: 'expense[splits_attributes][' + index + '][participant_amount]',
        class: 'participant-amount'
      }));
      var resultCell = $('<td>').append($('<input>').attr({
        type: 'number',
        name: 'expense[splits_attributes][' + index + '][participant_result]',
        readonly: true,
        class: 'participant-result'
      }));
      var idField = $('<input>').attr({
        type: 'hidden',
        name: 'expense[splits_attributes][' + index + '][participant_id]',
        value: participant
      });
      
      row.append(nameCell, inputCell, resultCell, idField);
      $('#dynamic-fields').append(row);

    });
  });
  // Event listener for split type selection
  /* $('#expense_split_type').change(function() {
    var splitType = $(this).val();
    
    // Change the label and validation of the dynamic fields
    $('.participant-amount').each(function() {
      if (splitType === 'by_percentage') {
        $(this).attr('max', 100);
      } else {
        $(this).removeAttr('max');
      }
    });
  }); */
  
  $(document).on('keydown change', '#amount, #expense_split_type, #expense_participant_ids, .participant-amount', updateResultFields);
  
    // Event listener for form submission
    $('form').submit(function(event) {
      event.preventDefault();
      
      // Calculate amounts for each participant
      var totalAmount = parseFloat($('#amount').val());
      $('.participant-amount').each(function() {
        var participantAmount = parseFloat($(this).val());
        if ($('#expense_split_type').val() === 'by_percentage') {
          $(this).val((participantAmount / 100) * totalAmount);
        }
      });
  
      // Submit the form
      this.submit();
    });
  });
  