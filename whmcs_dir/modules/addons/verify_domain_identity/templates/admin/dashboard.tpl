
{include file=$tplVar.header}

{if $tplVar['status']['status'] == "Error" }
    <div class="errorbox"><strong><span class="title">{$tplVar['status']['title']}</span></strong><br>{$tplVar['status']['message']}</div>
{elseif $tplVar['status']['status'] == "success"}
    <div class="successbox"><strong><span class="title">{$tplVar['status']['title']}</span></strong><br>{$tplVar['status']['message']}</div>
    {* <div class="successbox"><strong><span class="title">Changes Saved Successfully!</span></strong><br>Your changes have been saved.</div> *}
{/if}

<div style="margin-top: 30px;">
    <table id="summaryDomains" class="table table-themed dataTable" style="width: 100%">
        <thead>
            <tr role="row">
                <th>ID</th>
                <th>Domain</th>
                <th>Type</th>
                <th>Company Document</th>
                <th>Trade Mark</th>
                <th>Expirey Date</th>
                <th>Company Name</th>
                <th>Registration Date</th>
                <th>Status</th>
                <th>Documents</th>
                <th style="width:200px;">Action</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$tplVar['getRegisterDoamin'] item=item key=key name=name}
                <tr role="row" class="odd">
                    <td class="sorting_2"><a href="clientsdomains.php?userid={$item->userid}&amp;domainid={$item->domainid}">{$item->domainid}</a></td>
                    <td style="padding-left:5px;padding-right:5px"><a href="http://{$item->domain}" target="_blank">{$item->domain}</a></td>
                    <td>Resgistar</td>
                    <td>{$item->company_document}</td>
                    <td>{$item->trade_mark}</td>
                    <td>{$item->expirey_date}</td>
                    <td>{$item->company_name}</td>
                    <td>{$item->registrationdate}</td>
                    <td><span class='label {$item->status|lower}'>{$item->status}</span></td>
                    <td>
                        <ul style=" list-style-type:none;" >
                            {foreach $item->files as $domain_file }
                                {if isset($domain_file.full_name) && $domain_file.full_name !== ""}
                                    <li><a class='' href='/modules/addons/verify_domain_identity/uploadfile/{$domain_file.full_name}' download><span>{$domain_file.type}<i class="fas fa-download"></i></span></a></li>
                                {/if}
                            {/foreach}
                        </ul>
                    </td>
                    <td class=" edit text-center">
                        <a id='{$item->domainid}' {if $item->verify==1} disabled {/if} class='btn btn-success btn-sm verifydomain'>Accept</a>
                        <a id='{$item->domainid}' {if $item->rejected==1} disabled {/if} class='btn btn-danger btn-sm rejecteddomain'>Reject</a>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>

<form method="POST">
    <div class="modal fade" id="verifymodal" tabindex="-1" role="dialog" aria-labelledby="verifymodalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content panel panel-primary">

                <div class="modal-header panel-heading">
                    <button id="modalGeneratePasswordCloseSmall" type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                        <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title" id="verifymodalLabel">
                        Accept Document Verification
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label for="generatePwOutput" class="col-sm-4 col-form-label" style="text-align:right">Verification mail</label>
                        <div class="col-sm-8">
                            <input type='hidden' name='type' value='verify'>
                            <input type='hidden' name='domainid' id='verify-domain-id'>
                            <input type='checkbox' name='sendmail'>
                            <label>Check to send Verification mail.</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="generatePwOutput" class="col-sm-4 col-form-label" style="text-align:right">Register domain</label>
                        <div class="col-sm-8">
                            <input type='checkbox' name='domain'>  <label>Check to register command.</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-success"> Accept</button>
                </div>

            </div>
        </div>
    </div>
</form>


<form method="POST">
    <div class="modal fade" id="rejectedmodal" tabindex="-1" role="dialog" aria-labelledby="rejectedmodalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content panel panel-primary">

                <div class="modal-header panel-heading">
                    <button id="modalGeneratePasswordCloseSmall" type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                        <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title" id="rejectedmodalLabel">
                        Reject Document Verification
                    </h4>
                </div>
                <!------>
                <div class="modal-body">
                    <div class="form-group row">
                        <label for="generatePwOutput" class="col-sm-4 col-form-label" style="text-align:right">Rejection mail</label>
                        <div class="col-sm-8">
                            <input type='hidden' name='type' value='rejected'>
                            <input type='hidden' name='domainid' id='rejected-domain-id'>
                            <input type='checkbox' name='sendmail'>
                            <label>Check to send rejection mail.</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="generatePwOutput" class="col-sm-4 col-form-label" style="text-align:right">Reason</label>
                        <div class="col-sm-8">
                            <textarea name='reason' class='form-control'></textarea>
                        </div>
                    </div>

                </div>
                <!------>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" name="generateReport" value="true" class="btn btn-danger">Reject</button>
                </div>

            </div>
        </div>
    </div>
</form>

<script src='{$tplVar['asset']}/js/admin.js'></script>


{* {print_r($tplVar['status'])} *}