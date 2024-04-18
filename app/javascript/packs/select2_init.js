$(document).ready(function() {
    $('.select2').select2({
        dropdownParent: $('#expenseModal'), // replace with the id of your modal
        width: '100%' // to make the search bar wider
      });
  });
  

$(document).ready(function() {
    $('#expense_payer_id').change(function() {
      var payerId = $(this).val();
      $('#expense_participant_ids').val(payerId).trigger('change'); // trigger 'change' to update select2
    });
  });
  