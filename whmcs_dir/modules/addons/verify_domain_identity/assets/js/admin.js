$(document).ready(function () {

$("#summaryDomains").DataTable({
    "columnDefs": [
        { "orderable": false, "targets": 6 }
    ]
});

$(document).on('click', '.verifydomain', function () {
    $('#verify-domain-id').val($(this).attr('id'));
    $('#verifymodal').modal('show');
});

$(document).on('click', '.rejecteddomain', function () {
    $('#rejected-domain-id').val($(this).attr('id'));
    $('#rejectedmodal').modal('show')
});

});