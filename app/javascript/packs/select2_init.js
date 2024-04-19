$('#expenseModal').on('show.bs.modal', function () {
  $('#participants').select2({
    dropdownParent: $('#expenseModal')
  });
});


  $(document).ready(function() {
    $('.select2').select2({
        dropdownParent: $('#addFriendModal'),
        width: '100%' 
      });
  });
  

$(document).ready(function() {
    $('#expense_payer_id').change(function() {
      var payerId = $(this).val();
      $('#expense_participant_ids').val(payerId).trigger('change'); // trigger 'change' to update select2
    });
  });
  