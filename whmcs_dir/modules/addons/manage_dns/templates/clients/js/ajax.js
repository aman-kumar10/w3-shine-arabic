document.querySelectorAll('.toggle-header').forEach((header) => {
    header.addEventListener('click', function () {
        const dataBlock = header.nextElementSibling;
        const collapseIcon = header.querySelector('.collapseIcon');

        // Check if the clicked section is already open
        const isOpen = dataBlock.style.display === 'block';

        // Close all sections and reset icons
        document.querySelectorAll('.data-block').forEach((block) => {
            block.style.display = 'none';
        });
        document.querySelectorAll('.collapseIcon').forEach((icon) => {
            icon.textContent = '+';
        });

        // If the clicked section was not open, open it and change icon
        if (!isOpen) {
            dataBlock.style.display = 'block';
            collapseIcon.textContent = '-';
        }
    });
});


$(document).ready(function () {

    fetchAndDisplayARecords();
    $('#addarecord').on('click', function () {

        var hostname = $('#a-record-hostname').val();
        var ipAddress = $('#a-record-ipaddress').val();
        var ttl = $('#add-a-ttl').val();
        var res = $('#systemurl').val();
        var domainname = $('#domainname').val();
        var isValid = true;



        if (!ttl) {
            $('#add-a-ttl-required').css('display', 'block');
            isValid = false;
        }
        if (!ipAddress) {
            $('#add-a-ipaddress-required').css('display', 'block');

            isValid = false;
        } else if (!isValidIP(ipAddress)) {
            $('#add-a-ipaddress-required').text('Invalid IP Address').css('display', 'block');
            isValid = false;
        }


        if (isValid) {

            $.ajax({
                url: res + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    action: 'addARecords',
                    arecordhostname: hostname,
                    arecordipAddress: ipAddress,
                    arecordttl: ttl,
                    domainname: domainname
                },
                beforeSend() {
                    $(this).prop("disabled", true);
                    $("#addedarecordText").addClass("hidden");
                    $("#addedarecordLoading").removeClass("hidden");
                },
                success: function (data) {

                    let response = JSON.parse(data);


                    if (response.status == true) {
                        $("#addedarecordText").removeClass("hidden");
                        $("#addedarecordLoading").addClass("hidden");
                        $(".addarecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addarecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 5000);
                        fetchAndDisplayARecords();
                        $('#a-record-hostname').val('');
                        $('#a-record-ipaddress').val('');
                        $('#add-a-ttl').val('');
                    }

                },
                error: function (xhr, status, error) {

                    console.error('Error:', error);
                    alert('An error occurred while adding the A record.');
                }
            });
        }


    });


    $('#a-record-ipaddress').on('input', function () {
        var ipAddress = $(this).val();
        if (isValidIP(ipAddress)) {
            $('#add-a-ipaddress-required').css('display', 'none');
        } else {
            $('#add-a-ipaddress-required').text('Invalid IP Address').css('display', 'block');
        }
    });

    $('#add-a-ttl').on('input', function () {
        var ttl = $(this).val();
        if (ttl) {
            $('#add-a-ttl-required').css('display', 'none');
        } else {
            $('#add-a-ttl-required').css('display', 'block');
        }
    });

    $('#a-record-hostname,#txthostname,#maildomain,#cnamehostname,#srvhostname,#spfhostname').on('input', function () {
        $(this).val($(this).val().replace(/[@*]/g, ''));
    });


    $('#dnsRecordsTableBody').on('input', '#arecord-hostname', function () {
        // Replace any '@' or '*' characters in the input value with an empty string
        $(this).val($(this).val().replace(/[@*]/g, ''));
    });

    $('#txtRecordsTableBody').on('input', '#txtrecord-hostname', function () {
        // Replace any '@' or '*' characters in the input value with an empty string
        $(this).val($(this).val().replace(/[@*]/g, ''));
    });

    $('#mxRecordsTableBody').on('input', '.dtext[name="mxrecord-hostname"]', function () {
        $(this).val(function (index, value) {
            return value.replace(/[@*]/g, '');
        });
    });
    $('#cnameRecordsTableBody').on('input', '.dtext[name="cnamerecord-hostname"]', function () {
        $(this).val(function (index, value) {
            return value.replace(/[@*]/g, '');
        });
    });
    $('#srvRecordsTableBody').on('input', '.dtext[name="srvrecord-hostname"]', function () {
        $(this).val(function (index, value) {
            return value.replace(/[@*]/g, '');
        });
    });
    $('#spfRecordsTableBody').on('input', '.dtext[name="spfrecord-hostname"]', function () {
        $(this).val(function (index, value) {
            return value.replace(/[@*]/g, '');
        });
    });



    $('#dnsRecordsTableBody').on('click', '.delete-a-record', function () {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete?",
            icon: "warning",
            dangerMode: true,
            buttons: true,
        })
            .then((willdelete) => {
                if (willdelete) {
                    var row = $(this).closest("tr");  // Get the row closest to the clicked button

                    var hostname = row.find("input[id='arecord-hostname']").val();
                    var ipaddress = row.find("input[id='arecord-ipaddress']").val();
                    var systemurl = row.find("input[id='systemurl']").val();
                    var domainname = row.find("input[id='domainname']").val();
                    var recotrdid = row.find("input[id='recordid']").val();

                    var deleteText = row.find("#deleteaddarecordText");
                    var deleteLoading = row.find("#deleteaddarecordLoading");
                    var deleteButton = row.find(".delete-a-record");  // The button itself

                    $.ajax({
                        url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                        type: 'POST',
                        data: {
                            deleteaction: 'deleteARecords',
                            deletearecordhostname: hostname,
                            deletearecordipAddress: ipaddress,
                            deletedomainname: domainname,
                            deleterecotrdid: recotrdid
                        },
                        beforeSend: function () {

                            deleteButton.prop("disabled", true);
                            deleteText.addClass("hidden");
                            deleteLoading.removeClass("hidden"); // Show the loading spinner
                        },
                        success: function (data) {
                            let response = JSON.parse(data);

                            if (response.status == true) {
                                deleteText.removeClass("hidden");   // Show the "Delete" text
                                deleteLoading.addClass("hidden");  // Hide the loading spinner
                                swal("Record Deleted", response.message, "success");
                                fetchAndDisplayARecords();
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                            alert('An error occurred while deleting the A record.');
                            deleteButton.prop("disabled", false);
                            deleteText.removeClass("hidden");
                            deleteLoading.addClass("hidden");
                        }
                    });
                }
            });
    });



    $('#dnsRecordsTableBody').on('click', '.update-a-record', function () {

        let isValid = true;
        var row = $(this).closest("tr");

        var hostname = row.find("input[id='arecord-hostname']").val();
        var ipaddress = row.find("input[id='arecord-ipaddress']").val();
        var systemurl = row.find("input[id='systemurl']").val();
        var domainname = row.find("input[id='domainname']").val();
        var recotrdid = row.find("input[id='recordid']").val();
        var recordttl = row.find("input[id='recordttl']").val();

        var deleteText = row.find("#updateaddarecordText");
        var deleteLoading = row.find("#updateaddarecordLoading");
        var deleteButton = row.find(".update-a-record");

        const ipError = row.find('.update-a-ipaddress-required');

        // Validate IP Address
        if (!ipaddress) {
            ipError.text('Enter IP Address').css('display', 'block');  // Show error message in this row
            isValid = false;
        } else if (!isValidIP(ipaddress)) {
            ipError.text('Invalid IP Address').css('display', 'block');  // Show error message in this row
            isValid = false;
        } else {
            ipError.css('display', 'none');  // Hide the error message if valid
        }

        if (isValid) {

            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    updateaction: 'updateARecords',
                    updatearecordhostname: hostname,
                    updatearecordipAddress: ipaddress,
                    updatedomainname: domainname,
                    updaterecotrdid: recotrdid,
                    recordttl: recordttl
                },
                beforeSend: function () {

                    deleteButton.prop("disabled", true);
                    deleteText.addClass("hidden");
                    deleteLoading.removeClass("hidden");
                },
                success: function (data) {
                    let response = JSON.parse(data);

                    if (response.status == true) {
                        deleteText.removeClass("hidden");
                        deleteLoading.addClass("hidden");
                        $(".addarecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addarecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 5000);

                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('An error occurred while deleting the A record.');
                    deleteButton.prop("disabled", false);
                    deleteText.removeClass("hidden");
                    deleteLoading.addClass("hidden");
                }
            });
        }


    });


    $('#dnsRecordsTableBody').on('input', '#arecord-ipaddress', function () {
        const ipaddress = $(this).val();
        const ipError = $(this).closest("td").find('.update-a-ipaddress-required');

        if (!ipaddress) {
            ipError.text('Enter IP Address').css('display', 'block');
        } else if (!isValidIP(ipaddress)) {
            ipError.text('Invalid IP Address').css('display', 'block');
        } else {
            ipError.css('display', 'none');
        }
    });



    $('#addtxtrecord').on('click', function () {

        var txtrecord = $('#txtrecordsname').val();
        var addtxtttl = $('#add-txt-ttl').val();
        var hostname = $('#txthostname').val();
        var sytemurl = $('#txtsystem').val();
        var domainname = $('#txtdomain').val();
        var isValid = true;


        if (!txtrecord) {
            $('#add-txt-Record-required').css('display', 'block');
            isValid = false;
        } else {
            $('#add-txt-Record-required').css('display', 'none');
        }

        if (!addtxtttl) {
            $('#add-txt-ttl-required').css('display', 'block');
            isValid = false;
        } else {
            $('#add-txt-ttl-required').css('display', 'none');
        }



        if (isValid) {

            $.ajax({
                url: sytemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    addtxtaction: 'addtxtRecords',
                    addtxthostname: hostname,
                    addtxtipAddress: txtrecord,
                    addtxtttl: addtxtttl,
                    addtxtdomainname: domainname
                },
                beforeSend() {
                    $(this).prop("disabled", true);
                    $("#addedtxtrecordText").addClass("hidden");
                    $("#addedtxtrecordLoading").removeClass("hidden");
                },
                success: function (data) {

                    $(this).prop("disabled", false);
                    let response = JSON.parse(data);

                    if (response.status == true) {
                        $("#addedtxtrecordText").removeClass("hidden");
                        $("#addedtxtrecordLoading").addClass("hidden");
                        $(".addtxtrecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');
                        setTimeout(function () {
                            $(".addtxtrecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 5000);
                        fetchAndDisplayARecords();
                        var txtrecord = $('#txtrecordsname').val("");
                        var addtxtttl = $('#add-txt-ttl').val("");
                        var hostname = $('#txthostname').val("");
                    }

                },
                error: function (xhr, status, error) {

                    console.error('Error:', error);
                    alert('An error occurred while adding the A record.');
                }
            });
        }


    });

    $('#txtrecordsname').on('input', function () {
        var ipAddress = $(this).val();
        if (ipAddress) {
            $('#add-txt-Record-required').css('display', 'none');
        } else {
            $('#add-txt-Record-required').text('Enter TXT Record').css('display', 'block');
        }
    });

    $('#add-txt-ttl').on('input', function () {
        var ttl = $(this).val();
        if (ttl) {
            $('#add-txt-ttl-required').css('display', 'none');
        } else {
            $('#add-txt-ttl-required').css('display', 'block');
        }
    });


    $('#txtRecordsTableBody').on('click', '.update-txt-record', function () {

        let isValid = true;
        var row = $(this).closest("tr");

        var hostname = row.find("input[id='txtrecord-hostname']").val();
        var ipaddress = row.find("input[id='txtrecord-ipaddress']").val();
        var systemurl = row.find("input[id='txtsystemurl']").val();
        var domainname = row.find("input[id='txtdomainname']").val();
        var recotrdid = row.find("input[id='txtrecordid']").val();
        var recordttl = row.find("input[id='txtrecordttl']").val();

        var deleteText = row.find("#updateaddtxtrecordText");
        var deleteLoading = row.find("#updateaddtxtrecordLoading");
        var deleteButton = row.find(".update-txt-record");

        const ipError = row.find('.update-txt-ipaddress-required');

        if (!ipaddress) {
            $('#add-txt-Record-required').css('display', 'block');
            isValid = false;
        } else {
            $('#add-txt-Record-required').css('display', 'none');
        }


        if (isValid) {

            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    updatetxtaction: 'updatetxtRecords',
                    updatetxtrecordhostname: hostname,
                    updatetxtrecordipAddress: ipaddress,
                    updatetxtdomainname: domainname,
                    updatetxtrecotrdid: recotrdid,
                    recordtxtttl: recordttl
                },
                beforeSend: function () {

                    deleteButton.prop("disabled", true);
                    deleteText.addClass("hidden");
                    deleteLoading.removeClass("hidden"); // Show the loading spinner
                },
                success: function (data) {
                    let response = JSON.parse(data);

                    if (response.status == true) {
                        deleteText.removeClass("hidden");
                        deleteLoading.addClass("hidden");
                        $(".addtxtrecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addtxtrecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 5000);
                        fetchAndDisplayARecords()
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('An error occurred while updating the A record.');
                    deleteButton.prop("disabled", false);
                    deleteText.removeClass("hidden");
                    deleteLoading.addClass("hidden");
                }
            });
        }


    });

    $('#txtRecordsTableBody').on('input', '#txtrecord-ipaddress', function () {
        const ipaddress = $(this).val();
        const ipError = $(this).closest("td").find('.update-txt-ipaddress-required');

        if (!ipaddress) {
            ipError.css('display', 'block');
        } else {
            ipError.css('display', 'none');
        }
    });


    $('#txtRecordsTableBody').on('click', '.delete-txt-record', function () {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete?",
            icon: "warning",
            dangerMode: true,
            buttons: true,
        })
            .then((willdelete) => {
                if (willdelete) {
                    var row = $(this).closest("tr");  // Get the row closest to the clicked button

                    var hostname = row.find("input[id='txtrecord-hostname']").val();
                    var ipaddress = row.find("input[id='txtrecord-ipaddress']").val();
                    var systemurl = row.find("input[id='txtsystemurl']").val();
                    var domainname = row.find("input[id='txtdomainname']").val();
                    var recotrdid = row.find("input[id='txtrecordid']").val();

                    var deleteText = row.find("#deleteaddtxtrecordText");
                    var deleteLoading = row.find("#deleteaddtxtrecordLoading");
                    var deleteButton = row.find(".delete-txt-record");  // The button itself

                    $.ajax({
                        url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                        type: 'POST',
                        data: {
                            deletetxtaction: 'deletetxtRecords',
                            deletetxtrecordhostname: hostname,
                            deletetxtrecordipAddress: ipaddress,
                            deletetxtdomainname: domainname,
                            deletetxtrecotrdid: recotrdid
                        },
                        beforeSend: function () {

                            deleteButton.prop("disabled", true);
                            deleteText.addClass("hidden");
                            deleteLoading.removeClass("hidden"); // Show the loading spinner
                        },
                        success: function (data) {
                            let response = JSON.parse(data);

                            if (response.status == true) {
                                deleteText.removeClass("hidden");   // Show the "Delete" text
                                deleteLoading.addClass("hidden");  // Hide the loading spinner
                                fetchAndDisplayARecords()
                                swal("Record Deleted", response.message, "success");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                            alert('An error occurred while deleting the A record.');
                            deleteButton.prop("disabled", false);
                            deleteText.removeClass("hidden");
                            deleteLoading.addClass("hidden");
                        }
                    });
                }
            });
    });

    $('#addmxrecords').on('click', function () {

        var maildomain = $('#maildomain').val();
        var mailexchanger = $('#mailexchanger').val();
        var mailpriority = $('#mailpriority').val();
        var ttl = $('#add-mx-ttl').val();
        var domainname = $('#mxdomain').val();
        var systemurl = $('#systemurl').val();
        var isValid = true;


        if (!mailexchanger) {
            $('#mailexchangerequired').css('display', 'block');
            isValid = false;
        } else {
            $('#mailexchangerequired').css('display', 'none');
        }

        if (mailpriority === '') {
            $('#mailpriorityrequired').css('display', 'block');
            isValid = false;
        } else if (!/^\d+$/.test(mailpriority) || parseInt(mailpriority) < 0 || parseInt(mailpriority) > 65535) {
            $('#mailpriorityrequired').text('Invalid priority').css('display', 'block');
            isValid = false;
        } else {
            $('#mailpriorityrequired').css('display', 'none');
        }

        if (!ttl) {
            $('#add-mx-ttl-required').css('display', 'block');
            isValid = false;
        } else {
            $('#add-mx-ttl-required').css('display', 'none');
        }



        if (isValid) {

            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    addmxaction: 'addmxRecords',
                    addmxhostname: maildomain,
                    addmxipAddress: mailexchanger,
                    addmxttl: ttl,
                    addmxdomainname: domainname,
                    addpriority: mailpriority
                },
                beforeSend() {
                    $(this).prop("disabled", true);
                    $("#addedmxrecordText").addClass("hidden");
                    $("#addedmxrecordLoading").removeClass("hidden");
                },
                success: function (data) {

                    let response = JSON.parse(data);

                    if (response.status == true) {
                        $("#addedmxrecordText").removeClass("hidden");
                        $("#addedmxrecordLoading").addClass("hidden");
                        $(".addmxrecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');
                        setTimeout(function () {
                            $(".addmxrecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 5000);
                        fetchAndDisplayARecords();
                        $('#maildomain').val("");
                        $('#mailexchanger').val("");
                        $('#mailpriority').val("");
                        $('#add-mx-ttl').val("");
                    }

                },
                error: function (xhr, status, error) {

                    console.error('Error:', error);
                    alert('An error occurred while adding the A record.');
                }
            });
        }


    });

    $('#mailexchanger').on('input', function () {
        var ipAddress = $(this).val();
        if (ipAddress) {
            $('#mailexchangerequired').css('display', 'none');
        } else {
            $('#mailexchangerequired').text('Enter Mail Exchange').css('display', 'block');
        }
    });
    $('#add-mx-ttl').on('input', function () {
        var ipAddress = $(this).val();
        if (ipAddress) {
            $('#add-mx-ttl-required').css('display', 'none');
        } else {
            $('#add-mx-ttl-required').text('Select TTL').css('display', 'block');
        }
    });

    $('#mailpriority').on('input', function () {
        var mailpriority = $(this).val();

        if (mailpriority === '') {
            $('#mailpriorityrequired').text('Enter the priority').css('display', 'block');
        } else if (!/^\d+$/.test(mailpriority) || parseInt(mailpriority) < 0 || parseInt(mailpriority) > 65535) {
            $('#mailpriorityrequired').text('Invalid priority').css('display', 'block');
        } else {
            $('#mailpriorityrequired').css('display', 'none');
        }
    });


    $('#mxRecordsTableBody').on('click', '.update-mx-record', function () {

        let isValid = true;
        var row = $(this).closest("tr");


        var hostname = row.find("input[id='mxrecord-hostname']").val();
        var ipaddress = row.find("input[id='mxrecord-ipaddress']").val();
        var systemurl = row.find("input[id='mxsystemurl']").val();
        var domainname = row.find("input[id='mxdomainname']").val();
        var recotrdid = row.find("input[id='mxrecordid']").val();
        var recordttl = row.find("input[id='mxrecordttl']").val();
        var priority = row.find("input[id='mxrecord-priority']").val();

        var deleteText = row.find("#updateaddmxrecordText");
        var deleteLoading = row.find("#updateaddmxrecordLoading");
        var deleteButton = row.find(".update-mx-record");

        const ipError = row.find('.update-txt-ipaddress-required');

        if (!ipaddress) {
            $('#update-mx-ipaddress-required').css('display', 'block');
            isValid = false;
        } else {
            $('#update-mx-ipaddress-required').css('display', 'none');
        }

        if (!priority) {
            $('#update-mx-priority-required').css('display', 'block');
            isValid = false;
        } else {
            $('#update-mx-priority-required').css('display', 'none');
        }


        if (isValid) {

            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    updatemxaction: 'updatemxRecords',
                    updatemxrecordhostname: hostname,
                    updatemxrecordipAddress: ipaddress,
                    updatemxdomainname: domainname,
                    updatemxrecotrdid: recotrdid,
                    recordmxttl: recordttl,
                    recordmxpriority: priority
                },
                beforeSend: function () {

                    deleteButton.prop("disabled", true);
                    deleteText.addClass("hidden");
                    deleteLoading.removeClass("hidden");
                },
                success: function (data) {
                    deleteButton.prop("disabled", false);
                    let response = JSON.parse(data);

                    if (response.status == true) {
                        deleteText.removeClass("hidden");
                        deleteLoading.addClass("hidden");

                        $(".addmxrecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addmxrecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 10000);
                        fetchAndDisplayARecords()
                    }
                    else {

                        deleteText.removeClass("hidden");
                        deleteLoading.addClass("hidden");
                        $(".addmxrecordalert").html('<div class="alert alert-danger alert-dismissible"><strong>Error! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addmxrecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 10000);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('An error occurred while updating the MX record.');
                    // deleteButton.prop("disabled", false);
                    deleteText.removeClass("hidden");
                    deleteLoading.addClass("hidden");
                }
            });
        }


    });

    $('#mxRecordsTableBody').on('input', '#mxrecord-priority', function () {
        const ipaddress = $(this).val();
        const ipError = $(this).closest("td").find('.update-mx-priority-required');

        if (!ipaddress) {
            ipError.css('display', 'block');
        } else {
            ipError.css('display', 'none');
        }
    });

    $('#mxRecordsTableBody').on('input', '#mxrecord-ipaddress', function () {
        const ipaddress = $(this).val();
        const ipError = $(this).closest("td").find('.update-mx-ipaddress-required');
        $(this).val($(this).val().replace(/[@*]/g, ''));

        if (!ipaddress) {
            ipError.text('Enter Mail Exchanger').css('display', 'block');
        } else {
            ipError.css('display', 'none');
        }
    });

    $('#mxRecordsTableBody').on('click', '.delete-mx-record', function () {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete?",
            icon: "warning",
            dangerMode: true,
            buttons: true,
        })
            .then((willdelete) => {
                if (willdelete) {
                    var row = $(this).closest("tr");  // Get the row closest to the clicked button


                    var systemurl = row.find("input[id='mxsystemurl']").val();
                    var domainname = row.find("input[id='mxdomainname']").val();
                    var recotrdid = row.find("input[id='mxrecordid']").val();

                    var deleteText = row.find("#deleteaddmxrecordText");
                    var deleteLoading = row.find("#deleteaddmxrecordLoading");
                    var deleteButton = row.find(".delete-mx-record");

                    $.ajax({
                        url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                        type: 'POST',
                        data: {
                            deletemxaction: 'deletemxRecords',
                            deletemxdomainname: domainname,
                            deletemxrecotrdid: recotrdid
                        },
                        beforeSend: function () {

                            deleteButton.prop("disabled", true);
                            deleteText.addClass("hidden");
                            deleteLoading.removeClass("hidden"); // Show the loading spinner
                        },
                        success: function (data) {

                            deleteButton.prop("disabled", false);
                            let response = JSON.parse(data);

                            if (response.status == true) {
                                deleteText.removeClass("hidden");   // Show the "Delete" text
                                deleteLoading.addClass("hidden");  // Hide the loading spinner
                                fetchAndDisplayARecords()
                                swal("Record Deleted", response.message, "success");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                            alert('An error occurred while deleting the A record.');
                            deleteButton.prop("disabled", false);
                            deleteText.removeClass("hidden");
                            deleteLoading.addClass("hidden");
                        }
                    });
                }
            });
    });

    $('#addcname-record').on('click', function () {

        var hostname = $('#cnamehostname').val();
        var ipAddress = $('#cnameipaddress').val();
        var ttl = $('#add-cname-ttl').val();
        var systemurl = $('#cnamesystem').val();
        var domainname = $('#cnamedomain').val();
        var isValid = true;



        if (!ttl) {
            $('#cnamehost-cname-required').css('display', 'block');
            isValid = false;
        }
        if (!ipAddress) {
            $('#cnameipaddress-cname-required').css('display', 'block');
            isValid = false;
        }
        if (!ttl) {
            $('#add-cname-ttl-required').css('display', 'block');
            isValid = false;
        }


        if (isValid) {

            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    addcnameaction: 'addcnameRecords',
                    addcnamerecordhostname: hostname,
                    addcnamerecordipAddress: ipAddress,
                    addcnamerecordttl: ttl,
                    addcnamedomainname: domainname
                },
                beforeSend() {
                    $(this).prop("disabled", true);
                    $("#addedcnamerecordText").addClass("hidden");
                    $("#addedcnamerecordLoading").removeClass("hidden");
                },
                success: function (data) {

                    let response = JSON.parse(data);


                    if (response.status == true) {
                        $("#addedcnamerecordText").removeClass("hidden");
                        $("#addedcnamerecordLoading").addClass("hidden");
                        $(".addcnamerecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addcnamerecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 5000);
                        fetchAndDisplayARecords();
                        $('#cnamehostname').val('');
                        $('#cnameipaddress').val('');
                        $('#add-cname-ttl').val('');
                    }

                },
                error: function (xhr, status, error) {

                    console.error('Error:', error);
                    alert('An error occurred while adding the A record.');
                }
            });
        }


    });

    $('#cnameipaddress').on('input', function () {
        var ttl = $(this).val();
        if (ttl) {
            $('#cnameipaddress-cname-required').css('display', 'none');
        } else {
            $('#cnameipaddress-cname-required').css('display', 'block');
        }
    });
    $('#add-cname-ttl').on('input', function () {
        var ttl = $(this).val();
        if (ttl) {
            $('#add-cname-ttl-required').css('display', 'none');
        } else {
            $('#add-cname-ttl-required').css('display', 'block');
        }
    });

    $('#cnameRecordsTableBody').on('click', '.update-cname-record', function () {

        let isValid = true;
        var row = $(this).closest("tr");


        var hostname = row.find("input[id='cnamerecord-hostname']").val();
        var ipaddress = row.find("input[id='cnamerecord-ipaddress']").val();
        var systemurl = row.find("input[id='cnamesystemurl']").val();
        var domainname = row.find("input[id='cnamedomainname']").val();
        var recotrdid = row.find("input[id='cnamerecordid']").val();
        var recordttl = row.find("input[id='cnamerecordttl']").val();

        var deleteText = row.find("#updateaddcnamerecordText");
        var deleteLoading = row.find("#updateaddcnamerecordLoading");
        var deleteButton = row.find(".update-cname-record");


        if (!ipaddress) {
            $('#update-cname-ipaddress-required').css('display', 'block');
            isValid = false;
        } else {
            $('#update-cname-ipaddress-required').css('display', 'none');
        }



        if (isValid) {

            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    updatecnameaction: 'updatecnameRecords',
                    updatecnamerecordhostname: hostname,
                    updatecnamerecordipAddress: ipaddress,
                    updatecnamedomainname: domainname,
                    updatecnamerecotrdid: recotrdid,
                    recordcnamettl: recordttl,
                },
                beforeSend: function () {

                    deleteButton.prop("disabled", true);
                    deleteText.addClass("hidden");
                    deleteLoading.removeClass("hidden");
                },
                success: function (data) {
                    deleteButton.prop("disabled", false);
                    let response = JSON.parse(data);

                    if (response.status == true) {
                        deleteText.removeClass("hidden");
                        deleteLoading.addClass("hidden");

                        $(".addcnamerecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addcnamerecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 10000);
                        fetchAndDisplayARecords()
                    }
                    else {

                        deleteText.removeClass("hidden");
                        deleteLoading.addClass("hidden");
                        $(".addcnamerecordalert").html('<div class="alert alert-danger alert-dismissible"><strong>Error! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addcnamerecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 10000);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('An error occurred while updating the MX record.');
                    // deleteButton.prop("disabled", false);
                    deleteText.removeClass("hidden");
                    deleteLoading.addClass("hidden");
                }
            });
        }


    });

    $('#cnameRecordsTableBody').on('input', '#cnamerecord-ipaddress', function () {
        const ipaddress = $(this).val();
        const ipError = $(this).closest("td").find('#update-cname-ipaddress-required');

        if (!ipaddress) {
            ipError.text('Enter Cname Record').css('display', 'block');
        } else {
            ipError.css('display', 'none');
        }
    });

    $('#cnameRecordsTableBody').on('click', '.delete-cname-record', function () {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete?",
            icon: "warning",
            dangerMode: true,
            buttons: true,
        })
            .then((willdelete) => {
                if (willdelete) {
                    var row = $(this).closest("tr");  // Get the row closest to the clicked button


                    var systemurl = row.find("input[id='cnamesystemurl']").val();
                    var domainname = row.find("input[id='cnamedomainname']").val();
                    var recotrdid = row.find("input[id='cnamerecordid']").val();

                    var deleteText = row.find("#deleteaddcnamerecordText");
                    var deleteLoading = row.find("#deleteaddcnamerecordLoading");
                    var deleteButton = row.find(".delete-cname-record");

                    $.ajax({
                        url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                        type: 'POST',
                        data: {
                            deletecnameaction: 'deletecnameRecords',
                            deletecnamedomainname: domainname,
                            deletecnamerecotrdid: recotrdid
                        },
                        beforeSend: function () {

                            deleteButton.prop("disabled", true);
                            deleteText.addClass("hidden");
                            deleteLoading.removeClass("hidden"); // Show the loading spinner
                        },
                        success: function (data) {

                            deleteButton.prop("disabled", false);
                            let response = JSON.parse(data);

                            if (response.status == true) {
                                deleteText.removeClass("hidden");   // Show the "Delete" text
                                deleteLoading.addClass("hidden");  // Hide the loading spinner
                                fetchAndDisplayARecords()
                                swal("Record Deleted", response.message, "success");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                            alert('An error occurred while deleting the A record.');
                            deleteButton.prop("disabled", false);
                            deleteText.removeClass("hidden");
                            deleteLoading.addClass("hidden");
                        }
                    });
                }
            });
    });

    $('#addspf-record').on('click', function () {

        var hostname = $('#spfhostname').val();
        var ipAddress = $('#spfipaddress').val();
        var ttl = $('#add-ttl-spf').val();
        var systemurl = $('#spfsystem').val();
        var domainname = $('#spfdomain').val();
        var isValid = true;




        if (!ipAddress) {
            $('#spfipaddress-required').css('display', 'block');
            isValid = false;
        }
        if (!ttl) {
            $('#add-ttl-spf-required').css('display', 'block');
            isValid = false;
        }


        if (isValid) {

            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    addspfeaction: 'addspfeRecords',
                    addspferecordhostname: hostname,
                    addspferecordipAddress: ipAddress,
                    addspfrecordttl: ttl,
                    addspfedomainname: domainname
                },
                beforeSend() {
                    $(this).prop("disabled", true);
                    $("#addedspfrecordText").addClass("hidden");
                    $("#addedspfrecordLoading").removeClass("hidden");
                },
                success: function (data) {

                    $(this).prop("disabled", false);

                    let response = JSON.parse(data);


                    if (response.status == true) {
                        $("#addedspfrecordText").removeClass("hidden");
                        $("#addedspfrecordLoading").addClass("hidden");
                        $(".addspfrecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addspfrecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 5000);
                        fetchAndDisplayARecords();
                        $('#spfhostname').val('');
                        $('#spfipaddress').val('');
                        $('#add-ttl-spf').val('');
                    }
                    else {

                        deleteText.removeClass("hidden");
                        deleteLoading.addClass("hidden");
                        $(".addspferroralert").html('<div class="alert alert-danger alert-dismissible"><strong>Error! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addspferroralert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 10000);
                    }

                },
                error: function (xhr, status, error) {

                    console.error('Error:', error);
                    alert('An error occurred while adding the A record.');
                }
            });
        }


    });

    $('#spfipaddress').on('input', function () {
        const ipaddress = $(this).val();
        const ipError = $(this).closest("td").find('#spfipaddress-required');
        $(this).val($(this).val().replace(/[@*]/g, ''));

        if (!ipaddress) {
            ipError.text('Enter SPF Record').css('display', 'block');
        } else {
            ipError.css('display', 'none');
        }
    });
    $('#add-ttl-spf').on('input', function () {
        const ipaddress = $(this).val();
        const ipError = $(this).closest("td").find('#add-ttl-spf-required');
        $(this).val($(this).val().replace(/[@*]/g, ''));

        if (!ipaddress) {
            ipError.text('Select TTL').css('display', 'block');
        } else {
            ipError.css('display', 'none');
        }
    });

    $('#spfRecordsTableBody').on('click', '.delete-spf-record', function () {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete?",
            icon: "warning",
            dangerMode: true,
            buttons: true,
        })
            .then((willdelete) => {
                if (willdelete) {
                    var row = $(this).closest("tr");  // Get the row closest to the clicked button


                    var systemurl = row.find("input[id='spfsystemurl']").val();
                    var domainname = row.find("input[id='spfdomainname']").val();
                    var recotrdid = row.find("input[id='spfrecordid']").val();

                    var deleteText = row.find("#deleteaddspfrecordText");
                    var deleteLoading = row.find("#deleteaddspfrecordLoading");
                    var deleteButton = row.find(".delete-spf-record");

                    $.ajax({
                        url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                        type: 'POST',
                        data: {
                            deletespfaction: 'deletespfRecords',
                            deletespfdomainname: domainname,
                            deletespfrecotrdid: recotrdid
                        },
                        beforeSend: function () {

                            deleteButton.prop("disabled", true);
                            deleteText.addClass("hidden");
                            deleteLoading.removeClass("hidden"); // Show the loading spinner
                        },
                        success: function (data) {

                            deleteButton.prop("disabled", false);
                            let response = JSON.parse(data);

                            if (response.status == true) {
                                deleteText.removeClass("hidden");   // Show the "Delete" text
                                deleteLoading.addClass("hidden");  // Hide the loading spinner
                                fetchAndDisplayARecords()
                                swal("Record Deleted", response.message, "success");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                            alert('An error occurred while deleting the A record.');
                            deleteButton.prop("disabled", false);
                            deleteText.removeClass("hidden");
                            deleteLoading.addClass("hidden");
                        }
                    });
                }
            });
    });

    $('#spfRecordsTableBody').on('click', '.update-spf-record', function () {

        let isValid = true;
        var row = $(this).closest("tr");


        var hostname = row.find("input[id='spfrecord-hostname']").val();
        var ipaddress = row.find("input[id='spfrecord-ipaddress']").val();
        var systemurl = row.find("input[id='spfsystemurl']").val();
        var domainname = row.find("input[id='spfdomainname']").val();
        var recotrdid = row.find("input[id='spfrecordid']").val();

        var deleteText = row.find("#updateaddspfrecordText");
        var deleteLoading = row.find("#updateaddspfrecordLoading");
        var deleteButton = row.find(".update-spf-record");


        if (!ipaddress) {
            $('#update-spf-ipaddress-required').css('display', 'block');
            isValid = false;
        } else {
            $('#update-spf-ipaddress-required').css('display', 'none');
        }



        if (isValid) {

            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    updatespfaction: 'updatespfRecords',
                    updatespfrecordhostname: hostname,
                    updatespfrecordipAddress: ipaddress,
                    updatespfdomainname: domainname,
                    updatespfrecotrdid: recotrdid,
                    recordspfttl: recordttl,
                },
                beforeSend: function () {

                    deleteButton.prop("disabled", true);
                    deleteText.addClass("hidden");
                    deleteLoading.removeClass("hidden");
                },
                success: function (data) {
                    deleteButton.prop("disabled", false);
                    let response = JSON.parse(data);

                    if (response.status == true) {
                        deleteText.removeClass("hidden");
                        deleteLoading.addClass("hidden");

                        $(".addspfrecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addspfrecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 10000);
                        fetchAndDisplayARecords()
                    }
                    else {

                        deleteText.removeClass("hidden");
                        deleteLoading.addClass("hidden");
                        $(".addspferroralert").html('<div class="alert alert-danger alert-dismissible"><strong>Error! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addspferroralert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 10000);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('An error occurred while updating the MX record.');
                    // deleteButton.prop("disabled", false);
                    deleteText.removeClass("hidden");
                    deleteLoading.addClass("hidden");
                }
            });
        }


    });

    $('#spfRecordsTableBody').on('input', '#spfrecord-ipaddress', function () {
        const ipaddress = $(this).val();
        const ipError = $(this).closest("td").find('#update-spf-ipaddress-required');

        if (!ipaddress) {
            ipError.text('Enter SPF Record').css('display', 'block');
        } else {
            ipError.css('display', 'none');
        }
    });

    $('#addsrv-record').on('click', function () {

        var hostname = $('#srvhostname').val();
        var weight = $('#srvweight').val();
        var port = $('#srvport').val();
        var priority = $('#srvPriority').val();
        var ipAddress = $('#srvrecord').val();
        var ttl = $('#add-srv-ttl').val();
        var systemurl = $('#srvsystem').val();
        var domainname = $('#srvdomain').val();
        var isValid = true;



        if (!weight) {
            $('#srvweight-srv-required').css('display', 'block');
            isValid = false;
        }

        if (!port) {
            $('#srvport-srv-required').css('display', 'block');
            isValid = false;
        }

        if (!priority) {
            $('#srvPriority-srv-required').css('display', 'block');
            isValid = false;
        }

        if (!ipAddress) {
            $('#srvrecord-srv-required').css('display', 'block');
            isValid = false;
        }
        if (!ttl) {
            $('#add-srv-ttl-required').css('display', 'block');
            isValid = false;
        }



        if (isValid) {

            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    addsrveaction: 'addsrveRecords',
                    addsrverecordhostname: hostname,
                    addsrverecordrecord: ipAddress,
                    addsrvrecordttl: ttl,
                    addsrveweight: weight,
                    addsrveport: port,
                    addsrvepriority: priority,
                    addsrvdomainname: domainname
                },
                beforeSend() {
                    $(this).prop("disabled", true);
                    $("#addedsrvrecordText").addClass("hidden");
                    $("#addedsrvrecordLoading").removeClass("hidden");
                },
                success: function (data) {

                    $(this).prop("disabled", false);

                    let response = JSON.parse(data);


                    if (response.status == true) {
                        $("#addedsrvrecordText").removeClass("hidden");
                        $("#addedsrvrecordLoading").addClass("hidden");
                        $(".addsrvrecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addsrvrecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 5000);
                        fetchAndDisplayARecords();
                        $('#srvhostname').val('');
                        $('#srvweight').val('');
                        $('#srvport').val('');
                        $('#srvPriority').val('');
                        $('#srvrecord').val('');
                        $('#add-srv-ttl').val('');
                    }
                    else {

                        $("#addedsrvrecordText").removeClass("hidden");
                        $("#addedsrvrecordLoading").addClass("hidden");
                        $(".addsrverrordalert").html('<div class="alert alert-danger alert-dismissible"><strong>Error! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addsrverrordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 10000);
                    }

                },
                error: function (xhr, status, error) {

                    console.error('Error:', error);
                    alert('An error occurred while adding the A record.');
                }
            });
        }


    });

    $('#srvweight').on('input', function () {
        var weight = $(this).val();

        if (!weight) {
            $('#srvweight-srv-required').text('Enter Weight').css('display', 'block');
        } else if (!/^\d+$/.test(weight) || parseInt(weight) < 0 || parseInt(weight) > 65535) {
            $('#srvweight-srv-required').text('Invalid Weight').css('display', 'block');
        } else {
            $('#srvweight-srv-required').css('display', 'none');
        }
    });
    $('#srvport').on('input', function () {
        var weight = $(this).val();

        if (!weight) {
            $('#srvport-srv-required').text('Enter Weight').css('display', 'block');
        } else if (!/^\d+$/.test(weight) || parseInt(weight) < 0 || parseInt(weight) > 65535) {
            $('#srvport-srv-required').text('Invalid Port').css('display', 'block');
        } else {
            $('#srvport-srv-required').css('display', 'none');
        }
    });
    $('#srvPriority').on('input', function () {
        var weight = $(this).val();

        if (!weight) {
            $('#srvPriority-srv-required').text('Enter Weight').css('display', 'block');
        } else if (!/^\d+$/.test(weight) || parseInt(weight) < 0 || parseInt(weight) > 65535) {
            $('#srvPriority-srv-required').text('Invalid Priority').css('display', 'block');
        } else {
            $('#srvPriority-srv-required').css('display', 'none');
        }
    });

    $('#srvrecord').on('input', function () {
        var ttl = $(this).val();
        if (!ttl) {
            $('#srvrecord-srv-required').css('display', 'block');
        } else {
            $('#srvrecord-srv-required').css('display', 'none');
        }
    });
    $('#add-srv-ttl').on('input', function () {
        var ttl = $(this).val();
        if (!ttl) {
            $('#add-srv-ttl-required').css('display', 'block');
        } else {
            $('#add-srv-ttl-required').css('display', 'none');
        }
    });


    $('#srvRecordsTableBody').on('click', '.update-srv-record', function () {
        // Get the current row (tr) of the clicked button
        var row = $(this).closest('tr');

        // Get the values from the specific row's inputs
        var hostname = row.find('#srvrecord-hostname').val();
        var weight = row.find('#srvweight-hostname').val();
        var port = row.find('#srvport-hostname').val();
        var priority = row.find('#srvpriority-hostname').val();
        var ipAddress = row.find('#srvrecord-ipaddress').val();
        var systemurl = row.find('#srvsystemurl').val();
        var domainname = row.find('#srvdomainname').val();
        var srvrecordid = row.find('#srvrecordid').val();
        var ttl = row.find('#srvrecordttl').val();

        var isValid = true;

        if (!weight) {
            $('#srvweight-required').css('display', 'block');
            isValid = false;
        }

        if (!port) {
            $('#srvport-required').css('display', 'block');
            isValid = false;
        }

        if (!priority) {
            $('#srvpriority-required').css('display', 'block');
            isValid = false;
        }

        if (!ipAddress) {
            $('#update-srv-ipaddress-required').css('display', 'block');
            isValid = false;
        }

        // If validation passes, proceed with the AJAX request
        if (isValid) {
            $.ajax({
                url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                type: 'POST',
                data: {
                    updatesrveaction: 'updatesrveRecords',
                    updatesrverecordhostname: hostname,
                    updatesrverecordrecord: ipAddress,
                    updatesrveweight: weight,
                    updatesrveport: port,
                    updatesrvepriority: priority,
                    updatesrvdomainname: domainname,
                    updatesrvrecordid: srvrecordid,
                    updatesrvrecordttl: ttl
                },
                beforeSend: function () {
                    row.find('#update-srv-record').prop("disabled", true);
                    row.find("#updateaddsrvrecordText").addClass("hidden");
                    row.find("#updateaddsrvrecordLoading").removeClass("hidden");
                },
                success: function (data) {
                    $(this).prop("disabled", false);

                    let response = JSON.parse(data);

                    if (response.status == true) {
                        row.find("#updateaddsrvrecordText").removeClass("hidden");
                        row.find("#updateaddsrvrecordLoading").addClass("hidden");
                        $(".addsrvrecordalert").html('<div class="alert alert-success alert-dismissible"><strong>Success! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addsrvrecordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 10000);
                        fetchAndDisplayARecords();

                        // Clear the form fields
                        $('#srvhostname').val('');
                        $('#srvweight').val('');
                        $('#srvport').val('');
                        $('#srvPriority').val('');
                        $('#srvrecord').val('');
                        $('#add-srv-ttl').val('');
                    }
                    else {
                        row.find("#updateaddsrvrecordText").removeClass("hidden");
                        row.find("#updateaddsrvrecordLoading").addClass("hidden");
                        $(".addsrverrordalert").html('<div class="alert alert-danger alert-dismissible"><strong>Error! </strong>' + response.message + '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');

                        setTimeout(function () {
                            $(".addsrverrordalert").fadeOut("slow", function () {
                                $(this).html("");
                                $(this).show();
                            });
                        }, 5000);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('An error occurred while updating the SRV record.');
                }
            });
        }
    });

    $('#srvRecordsTableBody').on('input', '#srvweight-hostname', function () {
        const inputVal = $(this).val();
        const errorElement = $(this).closest("td").find('#srvweight-required');
    
        if (!inputVal) {
            // Show error if the input is empty
            errorElement.text('Enter SRV Weight').css('display', 'block');
        } else if (!/^\d{1,5}$/.test(inputVal) || parseInt(inputVal) > 65535) {
            // Show error if the input is not a valid number between 0 and 65535
            errorElement.text('Invalid Weight').css('display', 'block');
        } else {
            // Hide error if the input is valid
            errorElement.css('display', 'none');
        }
    });
    $('#srvRecordsTableBody').on('input', '#srvport-hostname', function () {
        const inputVal = $(this).val();
        const errorElement = $(this).closest("td").find('#srvport-required');
    
        if (!inputVal) {
            // Show error if the input is empty
            errorElement.text('Enter SRV Port').css('display', 'block');
        } else if (!/^\d{1,5}$/.test(inputVal) || parseInt(inputVal) > 65535) {
            // Show error if the input is not a valid number between 0 and 65535
            errorElement.text('Invalid Port').css('display', 'block');
        } else {
            // Hide error if the input is valid
            errorElement.css('display', 'none');
        }
    });
    $('#srvRecordsTableBody').on('input', '#srvpriority-hostname', function () {
        const inputVal = $(this).val();
        const errorElement = $(this).closest("td").find('#srvpriority-required');
    
        if (!inputVal) {
            // Show error if the input is empty
            errorElement.text('Enter SRV Priority').css('display', 'block');
        } else if (!/^\d{1,5}$/.test(inputVal) || parseInt(inputVal) > 65535) {
            // Show error if the input is not a valid number between 0 and 65535
            errorElement.text('Invalid Priority').css('display', 'block');
        } else {
            // Hide error if the input is valid
            errorElement.css('display', 'none');
        }
    });
    $('#srvRecordsTableBody').on('input', '#srvrecord-ipaddress', function () {
        const inputVal = $(this).val();
        const errorElement = $(this).closest("td").find('#update-srv-ipaddress-required');
    
        if (!inputVal) {
            // Show error if the input is empty
            errorElement.text('Enter SRV Records').css('display', 'block');
        } else {
            // Hide error if the input is valid
            errorElement.css('display', 'none');
        }
    });
    
    $('#srvRecordsTableBody').on('click', '.delete-srv-record', function () {
        swal({
            title: "Are you sure?",
            text: "Do you want to delete?",
            icon: "warning",
            dangerMode: true,
            buttons: true,
        })
            .then((willdelete) => {
                if (willdelete) {
                    var row = $(this).closest("tr");  // Get the row closest to the clicked button


                    var systemurl = row.find("input[id='srvsystemurl']").val();
                    var domainname = row.find("input[id='srvdomainname']").val();
                    var recotrdid = row.find("input[id='srvrecordid']").val();

                    var deleteText = row.find("#deleteaddsrvrecordText");
                    var deleteLoading = row.find("#deleteaddsrvrecordLoading");
                    var deleteButton = row.find(".delete-srv-record");

                    $.ajax({
                        url: systemurl + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
                        type: 'POST',
                        data: {
                            deletesrvcaction: 'deletesrvcRecords',
                            deletesrvcdomainname: domainname,
                            deletesrvcrecotrdid: recotrdid
                        },
                        beforeSend: function () {

                            deleteButton.prop("disabled", true);
                            deleteText.addClass("hidden");
                            deleteLoading.removeClass("hidden"); // Show the loading spinner
                        },
                        success: function (data) {

                            deleteButton.prop("disabled", false);
                            let response = JSON.parse(data);

                            if (response.status == true) {
                                deleteText.removeClass("hidden");   // Show the "Delete" text
                                deleteLoading.addClass("hidden");  // Hide the loading spinner
                                fetchAndDisplayARecords()
                                swal("Record Deleted", response.message, "success");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error);
                            alert('An error occurred while deleting the A record.');
                            deleteButton.prop("disabled", false);
                            deleteText.removeClass("hidden");
                            deleteLoading.addClass("hidden");
                        }
                    });
                }
            });
    });

    function isValidIP(ip) {

        const ipRegex = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
        return ipRegex.test(ip);
    }

    function fetchAndDisplayARecords() {

        const res = $('#systemurl').val();
        const domainname = $('#domainname').val();
        const updatebutton = $('#updatebutton').val();
        const deletebutton = $('#deletebutton').val();
        

        $.ajax({
            url: res + 'modules/addons/manage_dns/templates/clients/ajax/ajax.php',
            type: 'POST',
            data: {
                fetchaction: 'fetchARecords',
                fetchdomainname: domainname
            },
            success: function (data) {

                let response = JSON.parse(data);

                if (response.status === true) {
                    let recordsHtml = '';
                    let recordstxtHtml = '';
                    let recordsmxHtml = '';
                    let recordscanmeHtml = '';
                    let recordsspfHtml = '';
                    let recordssrvHtml = '';

                    // Iterate over response.data to build the table rows
                    Object.values(response.data).forEach(record => {
                        // Only process records of type 'A'
                        if (record.type === 'A') {
                            recordsHtml +=
                                `<tr>
                                <td class="ziehharmonika" align="left">
                                    <input name="arecord-hostname" type="text"
                                        id="arecord-hostname" class="dtext" value="${record.host}" >
                                    <span id="ctl00_ContentPlaceHolder1_GridView2_ctl02_lblArecorDomainsName">`+ domainname + `</span>
                                </td>
                                <td align="left">
                                    <input name="arecord-ipaddress" type="text" value="${record.record}" id="arecord-ipaddress" class="dtext">
                                    <span class="update-a-ipaddress-required" style="color:Red;display:none;">Enter IP
                                        Address</span>
                                    <input type="hidden" id="systemurl" value=`+ res + `>
                                    <input type="hidden" id="domainname" value=`+ domainname + `>
                                    <input type="hidden" id="recordid" value="${record.id}">
                                    <input type="hidden" id="recordttl" value="${record.ttl}">
                                </td>
                                <td align="left" style="width:40%;">
                                    <button type="button" class="update-a-record upd"><span
                                        id="updateaddarecordText">
                                        `+ updatebutton + `
                                    </span>
                                    <span id="updateaddarecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                        Loading...</span></button>

                                    <button type="button" class="delete-a-record dlte"><span
                                        id="deleteaddarecordText">
                                        `+ deletebutton + `
                                    </span>
                                    <span id="deleteaddarecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                        Loading...</span></button>
                                </td>
                            </tr>`;
                        }
                        if (record.type === 'TXT') {
                            recordstxtHtml +=
                                `<tr>
                                    <td class="ziehharmonika" align="left">
                                        <input name="txtrecord-hostname" type="text"
                                            id="txtrecord-hostname" class="dtext" value="${record.host}" >
                                        <span>`+ domainname + `</span>
                                    </td>
                                    <td align="left">
                                        <input name="txtrecord-ipaddress" type="text" value="${record.record}" id="txtrecord-ipaddress" class="dtext">
                                        <span class="update-txt-ipaddress-required" style="color:Red;display:none;">Enter IP
                                            Address</span>
                                        <input type="hidden" id="txtsystemurl" value=`+ res + `>
                                        <input type="hidden" id="txtdomainname" value=`+ domainname + `>
                                        <input type="hidden" id="txtrecordid" value="${record.id}">
                                        <input type="hidden" id="txtrecordttl" value="${record.ttl}">
                                    </td>
                                    <td align="left" style="width:40%;">
                                        <button type="button" class="update-txt-record upd"><span
                                            id="updateaddtxtrecordText">
                                            `+ updatebutton + `
                                        </span>
                                        <span id="updateaddtxtrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>

                                        <button type="button" class="delete-txt-record dlte"><span
                                            id="deleteaddtxtrecordText">
                                            `+ deletebutton + `
                                        </span>
                                        <span id="deleteaddtxtrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>
                                    </td>
                                </tr>`;
                        }
                        if (record.type === 'MX') {
                            recordsmxHtml +=
                                `<tr>
                                    <td class="ziehharmonika" align="left">
                                        <input name="mxrecord-hostname" type="text"
                                            id="mxrecord-hostname" class="dtext" value="${record.host}" >
                                        <span>`+ domainname + `</span>
                                    </td>
                                    <td align="left">
                                        <input name="mxrecord-ipaddress" type="text" value="${record.record}" id="mxrecord-ipaddress" class="dtext">
                                        <span class="update-mx-ipaddress-required" style="color:Red;display:none;">Enter Mail Exchanger</span>
                                        <input type="hidden" id="mxsystemurl" value=`+ res + `>
                                        <input type="hidden" id="mxdomainname" value=`+ domainname + `>
                                        <input type="hidden" id="mxrecordid" value="${record.id}">
                                        <input type="hidden" id="mxrecordttl" value="${record.ttl}">
                                        <input type="hidden" id="mxrecordpriority" value="${record.priority}">
                                    </td>
                                    <td align="left">
                                        <input name="mxrecord-priority" type="text"
                                            id="mxrecord-priority" class="dtext" value="${record.priority}">

                                        <span class="update-mx-priority-required" id = "update-mx-priority-required" style="color:Red;display:none;">Enter priority</span>
                                    </td>
                                    <td align="left" style="width:40%;">
                                        <button type="button" class="update-mx-record upd"><span
                                            id="updateaddmxrecordText">
                                            `+ updatebutton + `
                                        </span>
                                        <span id="updateaddmxrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>

                                        <button type="button" class="delete-mx-record dlte"><span
                                            id="deleteaddmxrecordText">
                                            `+ deletebutton + `
                                        </span>
                                        <span id="deleteaddmxrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>
                                    </td>
                                </tr>`;
                        }
                        if (record.type === 'CNAME') {
                            recordscanmeHtml +=
                                `<tr>
                                    <td class="ziehharmonika" align="left">
                                        <input name="cnamerecord-hostname" type="text"
                                            id="cnamerecord-hostname" class="dtext" value="${record.host}" >
                                        <span>`+ domainname + `</span>
                                    </td>
                                    <td align="left">
                                        <input name="cnamerecord-ipaddress" type="text" value="${record.record}" id="cnamerecord-ipaddress" class="dtext">
                                        <span id="update-cname-ipaddress-required" style="color:Red;display:none;">Enter Cname Record</span>
                                        <input type="hidden" id="cnamesystemurl" value=`+ res + `>
                                        <input type="hidden" id="cnamedomainname" value=`+ domainname + `>
                                        <input type="hidden" id="cnamerecordid" value="${record.id}">
                                        <input type="hidden" id="cnamerecordttl" value="${record.ttl}">
                                    </td>
                                    <td align="left" style="width:40%;">
                                        <button type="button" class="update-cname-record upd"><span
                                            id="updateaddcnamerecordText">
                                            `+ updatebutton + `
                                        </span>
                                        <span id="updateaddcnamerecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>

                                        <button type="button" class="delete-cname-record dlte"><span
                                            id="deleteaddcnamerecordText">
                                            `+ updatebutton + `
                                        </span>
                                        <span id="deleteaddcnamerecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>
                                    </td>
                                </tr>`;
                        }
                        if (record.type === 'SPF') {
                            recordsspfHtml +=
                                `<tr>
                                    <td class="ziehharmonika" align="left">
                                        <input name="spfrecord-hostname" type="text"
                                            id="spfrecord-hostname" class="dtext" value="${record.host}" >
                                        <span>`+ domainname + `</span>
                                    </td>
                                    <td align="left">
                                        <input name="spfrecord-ipaddress" type="text" value="${record.record}" id="spfrecord-ipaddress" class="dtext">
                                        <span id="update-spf-ipaddress-required" style="color:Red;display:none;">Enter Mail Exchanger</span>
                                        <input type="hidden" id="spfsystemurl" value=`+ res + `>
                                        <input type="hidden" id="spfdomainname" value=`+ domainname + `>
                                        <input type="hidden" id="spfrecordid" value="${record.id}">
                                        <input type="hidden" id="spfrecordttl" value="${record.ttl}">
                                    </td>
                                    <td align="left" style="width:40%;">
                                        <button type="button" class="update-spf-record upd"><span
                                            id="updateaddspfrecordText">
                                           `+ updatebutton + `
                                        </span>
                                        <span id="updateaddspfrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>

                                        <button type="button" class="delete-spf-record dlte"><span
                                            id="deleteaddspfrecordText">
                                            `+ deletebutton + `
                                        </span>
                                        <span id="deleteaddspfrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>
                                    </td>
                                </tr>`;
                        }
                        if (record.type === 'SRV') {
                            recordssrvHtml +=
                                `<tr>
                                    <td class="ziehharmonika" align="left">
                                        <input name="srvrecord-hostname" type="text"
                                            id="srvrecord-hostname" class="dtext" value="${record.host}" >
                                        <span>`+ domainname + `</span>
                                    </td> 
                                    <td class="ziehharmonika" align="left">
                                        <input name="srvweight-hostname" type="text"
                                            id="srvweight-hostname" class="dtext" value="${record.weight}" >
                                        <span id="srvweight-required" style="color:Red;display:none;">Enter SRV Weight</span>
                                    </td>
                                    <td class="ziehharmonika" align="left">
                                        <input name="srvport-hostname" type="text"
                                            id="srvport-hostname" class="dtext" value="${record.port}" >
                                        <span id="srvport-required" style="color:Red;display:none;">Enter SRV Port</span>
                                    </td>
                                    <td class="ziehharmonika" align="left">
                                        <input name="srvpriority-hostname" type="text"
                                            id="srvpriority-hostname" class="dtext" value="${record.priority}" >
                                        <span id="srvpriority-required" style="color:Red;display:none;">Enter SRV Priority</span>
                                    </td>
                                    <td align="left">
                                        <input name="srvrecord-ipaddress" type="text" value="${record.record}" id="srvrecord-ipaddress" class="dtext">
                                        <span id="update-srv-ipaddress-required" style="color:Red;display:none;">Enter SRV Record</span>
                                        <input type="hidden" id="srvsystemurl" value=`+ res + `>
                                        <input type="hidden" id="srvdomainname" value=`+ domainname + `>
                                        <input type="hidden" id="srvrecordid" value="${record.id}">
                                        <input type="hidden" id="srvrecordttl" value="${record.ttl}">
                                    </td>
                                    <td align="left" style="width:40%;">
                                        <button type="button" class="update-srv-record upd" id = "update-srv-record"><span
                                            id="updateaddsrvrecordText">
                                            `+ updatebutton + `
                                        </span>
                                        <span id="updateaddsrvrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>

                                        <button type="button" class="delete-srv-record dlte"><span
                                            id="deleteaddsrvrecordText">
                                           `+ deletebutton + `
                                        </span>
                                        <span id="deleteaddsrvrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>
                                    </td>
                                </tr>`;
                        }
                    });

                    // Update the table body with the generated HTML
                    $('#dnsRecordsTableBody').html(recordsHtml);
                    $('#txtRecordsTableBody').html(recordstxtHtml);
                    $('#mxRecordsTableBody').html(recordsmxHtml);
                    $('#cnameRecordsTableBody').html(recordscanmeHtml);
                    $('#spfRecordsTableBody').html(recordsspfHtml);
                    $('#srvRecordsTableBody').html(recordssrvHtml);

                    $('#aRecordsTableHead').toggle(!!recordsHtml);
                    $('#txtRecordsTableHead').toggle(!!recordstxtHtml);
                    $('#mxRecordsTableHead').toggle(!!recordsmxHtml);
                    $('#cnameRecordsTableHead').toggle(!!recordscanmeHtml);
                    $('#spfRecordsTableHead').toggle(!!recordsspfHtml);
                    $('#srvRecordsTableHead').toggle(!!recordssrvHtml);
                }
            },
            error: function (xhr, status, error) {
                console.error('Error fetching A records:', error);
            }
        });
    }

});