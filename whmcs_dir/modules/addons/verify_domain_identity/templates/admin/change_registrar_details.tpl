
{include file=$tplVar.header}

<style>
.change-registrant-modal {
    font-family: Arial, sans-serif;
    font-size: 14px;
}

.change-registrant-modal .modal-header {
    background-color: #2a8fce;
    color: #fff;
    padding: 15px;
    border-bottom: 1px solid #ddd;
}

.change-registrant-modal .modal-title {
    font-size: 18px;
    font-weight: bold;
}

.change-registrant-modal .modal-body {
    padding: 20px;
}

.change-registrant-modal .reason-heading h3 {
    background-color: #2a8fce;
    color: #fff;
    padding: 10px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 5px;
    margin-bottom: 15px;
}

.change-registrant-modal label {
    font-weight: bold;
    display: block;
    margin-bottom: 5px;
}

.change-registrant-modal .form-control {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 8px;
    width: 100%;
}

.change-registrant-modal input[type="checkbox"] {
    margin-right: 8px;
}

.change-registrant-modal textarea {
    width: 100%;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 8px;
}

.change-registrant-modal button[type="submit"] {
    background-color: #2a8fce;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
}

.change-registrant-modal button[type="submit"]:hover {
    background-color: #0056b3;
}

.change-registrant-modal .domin_owner-box {
    margin-top: 15px;
}

.change-registrant-modal .t-check {
    margin-right: 5px;
}

.change-registrant-modal .row {
    margin-bottom: 15px;
}

.change-registrant-modal .form-group {
    margin-top: 20px;
}

</style>

{if $tplVar['status']['status'] == "Error" }
    <div class="errorbox"><strong><span class="title">{$tplVar['status']['title']}</span></strong><br>{$tplVar['status']['message']}</div>
{elseif $tplVar['status']['status'] == "success"}
    <div class="successbox"><strong><span class="title">{$tplVar['status']['title']}</span></strong><br>{$tplVar['status']['message']}</div>
{/if}

<div style="margin-top: 30px;">
    <table id="summaryDomains" class="table table-themed  dataTable" style="width: 100%">
        <thead>
            <tr role="row">
                <th>ID</th>
                <th>Domain</th>
                <th>Client</th>
                <th>Status</th>
                <th style="width:200px;">Action</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$tplVar['change_contact_details'] item=item key=key name=name}
                <tr role="row" class="odd">
                    <td class="sorting_2"><a href="clientsdomains.php?userid={$item->client_id}&amp;domainid={$item->domain_id}">{$item->domain_id}</a></td> 
                    <td style="padding-left:5px;padding-right:5px"><a href="http://{$item->domain_name}" target="_blank">{$item->domain_name}</a></td>
                    <td><a href="/clientssummary.php?userid={$item->client_id}">{$item->user_name}</a></td>
                    <td>{$item->domain_status}</td>
                    <td class="edit text-center">
                        <a id='{$item->domain_id}' data-id='{$item->domain_id}' class='btn btn-success view_domain_details btn-sm'>View</a>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>


<div class="modal fade change-registrant-modal" id="changeRegistrantNameModal" tabindex="-1" role="dialog" aria-labelledby="changeRegistrantNameModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changeRegistrantNameModalLabel">Application for Change of Owner (Registrant)</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="changeRegistrantNameForm" action="" method="post">
                    <div class="reason-heading">
                        <h3 class="reason-docs">Domain Details</h3>
                    </div>

                    <div class="reason-heading">
                        <h3 class="reason-docs">Reason of Transfer / Documentation</h3>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label>Reason Of Transfer</label>
                            <textarea name="transfer_reason" rows="2" cols="20" id="transfer_reason" class="form-control"></textarea>
                        </div>
                        <div class="col-md-6">
                            <label>Attach relevent document</label>
                            <input type="file" name="relevant_doc" id="relevant_doc">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 domin_owner-box">
                            <span class="t-check">
                                <input id="check_owner" type="checkbox" name="check_owner">
                            </span>I
                            <input name="owner_name" type="text" id="owner_name" class="req">
                            <span>certify that all the information I have furnished in this declaration are true and correct, and I understand that any false or misleading information may be subject to an offence under the laws in the State of Qatar.</span> 
                        </div>
                    </div>

                    <div class="reason-heading">
                        <h3 class="reason-docs">Policies</h3>
                    </div>

                    <div class="row mt-2">
                        <div class="col-md-12">
                            <span class="t-check">
                                <input id="ctl00_ContentPlaceHolder1_CheckBox2" type="checkbox" name="ctl00$ContentPlaceHolder1$CheckBox2">
                            </span>General Policies
                        </div>
                        <div class="col-md-12">
                            <span class="t-check">
                                <input id="ctl00_ContentPlaceHolder1_CheckBox2" type="checkbox" name="ctl00$ContentPlaceHolder1$CheckBox2">
                            </span>Registrar - Registrant Agreement
                        </div>
                    </div>
                    <div class="reason-heading">
                        <h3  class="reason-docs">DECLARATION OF NEW REGISTRANT(DOMAIN OWNER)</h3>
                    </div>

                    <div class="row mt-2">
                        <div class="col-md-12 domin_owner-box">
                            <span class="t-check">
                                <input id="domain_check_owner" type="checkbox" name="domain_check_owner">
                            </span>I
                            <input name="domin_owner_name" type="text" id="domin_owner_name" class="req">
                            <span>
                            , makes the following declaration in accordance with the laws of the State of Qatar, I certify that all the information I have furnished in this declaration are true and correct, and I understand that any false or misleading information may be subject to an offence under the laws in the State of Qatar.
                            </span>
                        </div>
                    </div>


                    <div class="row mt-2">
                        <div class="col-md-6">
                            <label>Printed Name</label>
                            <input type="text" name="printed_name" class="form-control"/>                         
                        </div>
                        <div class="col-md-6">
                            <label>Organization Name</label>
                            <input type="text" name="organization_name" class="form-control"/>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $(document).on('click', '.view_domain_details', function () {
            const domainId = $(this).data('id');
            $.ajax({
                type: "POST",
                url: window.location.href,
                data: { "callFor": "get_domain_data", domainId},
                success: function (result) {
                    var result = JSON.parse(result);
                    if(result.status == 'success'){
                        try {
                            const parsedData = JSON.parse(result.value);
                            $('#transfer_reason').val(parsedData.transfer_reason);
                            $('#owner_name').val(parsedData.owner_name);
                            $('#domin_owner_name').val(parsedData.domin_owner_name);
                            $('#domain_id').val(parsedData.domain_id);
                            $('#amount').val(parsedData.amount);
                            $('#printed_name').val(parsedData.printed_name);
                            $('input[name="organization_name"]').val(parsedData.organization_name);
                            $('#changeRegistrantNameModal').modal('show');
                        } catch (error) {
                            console.error("Invalid JSON in data-value:", dataValue);
                            alert("Failed to load domain details. Please try again.");
                        }
                    }else{
                        alert('No Registrar Details Found');
                    }
                }
            });
        });
    });
</script>
    

<script src='{$tplVar['asset']}/js/admin.js'></script>



