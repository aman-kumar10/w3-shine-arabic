<div class="container custom-domain-details">
    
    <div class="sidebar">
        {include file="$template/includes/domain_navbar.tpl" sidebar=$primarySidebar}
    </div>
    
    <div class="card">
        <div class="card-body">
            {if $successful}
                {include file="$template/includes/alert.tpl" type="success" msg="{lang key='changessavedsuccessfully'}" textcenter=true}
            {/if}

            {if $pending}
                {include file="$template/includes/alert.tpl" type="info" msg=$pendingMessage textcenter=true}
            {/if}

            {if $domainInformation && !$pending && $domainInformation->getIsIrtpEnabled() && $domainInformation->isContactChangePending()}
                {if $domainInformation->getPendingSuspension()}
                    {include file="$template/includes/alert.tpl" type="warning" msg="<strong>{lang key='domains.verificationRequired'}</strong><br>{lang key='domains.newRegistration'}" textcenter=true}
                {else}
                    {include file="$template/includes/alert.tpl" type="info" msg="<strong>{lang key='domains.contactChangePending'}</strong><br>{lang key='domains.contactsChanged'}" textcenter=true}
                {/if}
            {/if}

            {if $error}
                {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
            {/if}

            <h3 class="card-title">{lang key='domaincontactinfo'}</h3>

            <p>{lang key='whoisContactWarning'}</p>

            <form method="post" action="{$smarty.server.PHP_SELF}?action=domaincontacts" id="frmDomainContactModification">

                <input type="hidden" name="sub" value="save" />
                <input type="hidden" name="domainid" value="{$domainid}" />

                <ul class="nav nav-tabs responsive-tabs-sm" role="tablist">
                    {foreach $contactdetails as $contactdetail => $values}
                        <li class="nav-item">
                            <a class="nav-link{if $values@first} active{/if}" id="tabSelector{$contactdetail}" data-toggle="tab" href="#tab{$contactdetail}" role="tab">{$contactdetail}</a>
                        </li>
                    {/foreach}
                </ul>
                <div class="responsive-tabs-sm-connector"><div class="channel"></div><div class="bottom-border"></div></div>
                <div class="tab-content p-4">
                    {foreach $contactdetails as $contactdetail => $values}
                        <div class="tab-pane fade{if $values@first} show active{/if}" id="tab{$contactdetail}" role="tabpanel">

                            <div class="form-check">
                                <label>
                                    <input type="radio" class="form-check-input" name="wc[{$contactdetail}]" id="{$contactdetail}1" value="contact" onclick="useDefaultWhois(this.id)" />
                                    {lang key='domaincontactusexisting'}
                                </label>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <label for="{$contactdetail}3">{lang key='domaincontactchoose'}</label>
                                        <input type="hidden" name="sel[{$contactdetail}]" value="">
                                        <select id="{$contactdetail}3" class="form-control custom-select {$contactdetail}defaultwhois" name="sel[{$contactdetail}]" disabled>
                                            <option value="u{$clientsdetails.userid}">{lang key='domaincontactprimary'}</option>
                                            {foreach $contacts as $contact}
                                                <option value="c{$contact.id}">{$contact.name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-check">
                                <label>
                                    <input type="radio" class="form-check-input" name="wc[{$contactdetail}]" id="{$contactdetail}2" value="custom" onclick="useCustomContact(this.id)" checked />
                                    {lang key='domaincontactusecustom'}
                                </label>
                            </div>

                            <div class="contact_form_group">

                                {foreach $values as $name => $value}
                                    <div class="form-group">
                                        <label>{$contactdetailstranslations[$name]}</label>
                                        <input type="text" name="contactdetails[{$contactdetail}][{$name}]" value="{$value}" data-original-value="{$value}" class="form-control {$contactdetail}customwhois{if array_key_exists($contactdetail, $irtpFields) && in_array($name, $irtpFields[$contactdetail])} irtp-field{/if}" {if in_array($name, $contactRequiredArray)} readonly {/if} />                         
                                    </div>
                                {/foreach}
                            </div>

                        </div>
                    {/foreach}
                </div>

                <p class="text-center contact_information-btns">
                    {if $domainInformation && $irtpFields}
                        <input id="irtpOptOut" type="hidden" name="irtpOptOut" value="0">
                        <input id="irtpOptOutReason" type="hidden" name="irtpOptOutReason" value="">
                    {/if}
                    <button type="submit" class="btn btn-primary">
                        {lang key='clientareasavechanges'}
                    </button>
                    <button type="reset" class="btn btn-default">
                        {lang key='clientareacancel'}
                    </button>
                    <a class="btn btn-default changeRegistrantName" data-toggle="modal" data-target="#changeRegistrantNameModal">
                        Click Here to Change the Registrant Name
                    </a>
                    
                </p>

            </form>

        </div>
    </div>

    {if $domainInformation && $irtpFields}
        <div class="modal fade" id="modalIRTPConfirmation" role="dialog" aria-labelledby="IRTPConfirmationLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content card">
                    <div id="modalIRTPConfirmationHeading" class="modal-header card-header bg-primary text-light">
                        <h4 class="modal-title" id="IRTPConfirmationLabel">{lang key='domains.importantReminder'}</h4>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">{lang key='orderForm.close'}</span>
                        </button>
                    </div>
                    <div id="modalIRTPConfirmationBody" class="modal-body card-body text-center">
                        <div class="row">
                            <div class="col-sm-10 offset-sm-1">
                                {lang key='domains.irtpNotice'}
                            </div>
                            <div class="col-sm-12">
                                <div class="checkbox-inline">
                                    <label for="modalIrtpOptOut">
                                        <input id="modalIrtpOptOut" class="form-check-input" type="checkbox" value="1">
                                        {lang key='domains.optOut'}
                                    </label>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12 text-left">
                                        <label for="modalReason">{lang key='domains.optOutReason'}</label>:
                                    </div>
                                    <div class="col-sm-12">
                                        <input id="modalReason" type="text" class="form-control input-600" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="modalIRTPConfirmationFooter" class="modal-footer card-footer">
                        <button type="button" id="IRTPConfirmation-Submit" class="btn btn-primary" onclick="irtpSubmit();return false;">
                            {lang key='supportticketsticketsubmit'}
                        </button>
                        <button type="button" id="IRTPConfirmation-Cancel" class="btn btn-default" data-dismiss="modal">
                            {lang key='cancel'}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    {/if}

    <div class="modal fade" id="changeRegistrantNameModal" tabindex="-1" role="dialog" aria-labelledby="changeRegistrantNameModalLabel" aria-hidden="true">
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
                        {foreach $contactdetails as $contactdetail => $values}
                            {if $values@first}
                                <div class="contact_form_group">
                                    {foreach $values as $name => $value}
                                        <div class="form-group">
                                            <label>{$contactdetailstranslations[$name]}</label>
                                            <input type="text" name="contactdetails[{$contactdetail}][{$name}]" value="{$value}" data-original-value="{$value}" class="form-control {$contactdetail}customwhois{if array_key_exists($contactdetail, $irtpFields) && in_array($name, $irtpFields[$contactdetail])} irtp-field{/if}" {if in_array($name, $contactRequiredArray)} readonly {/if} />                         
                                        </div>
                                    {/foreach}
                                </div>
                            {/if}
                        {/foreach}
                        <div class="reason-heading">
                            <h3 class="reason-docs">Reason of Transfer / Documentation</h3>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <label>Reason Of Transfer</label>
                                <textarea name="transfer_reason" rows="2" cols="20" id="transfer_reason" class="form-control" ></textarea>
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
                            <h3 class="reason-docs">New Owner Contact Details</h3>
                        </div>

                        {foreach $contactdetails as $contactdetail => $values}
                            <h3 class="reason-docs">{$contactdetail}</h3>
                            <div class="contact_form_group">
                                {foreach $values as $name => $value}
                                    <div class="form-group">
                                        <label>{$contactdetailstranslations[$name]}</label>
                                        <input type="text" name="contactdetails[{$contactdetail}][{$name}]" value="{$value}" data-original-value="{$value}" class="form-control {$contactdetail}customwhois{if array_key_exists($contactdetail, $irtpFields) && in_array($name, $irtpFields[$contactdetail])} irtp-field{/if}" {if in_array($name, $contactRequiredArray)} readonly {/if} />                         
                                    </div>
                                {/foreach}
                            </div>
                        {/foreach}



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



                        <div class="form-group">
                            <label for="newRegistrantName">You have to pay QAR.40 to change the registrant name</label>
                            <input type="hidden" name="change_registrant_name" value="true"/>
                            <input type="hidden" id="domain_id" name="domain_id" class="form-control" value="{$domainid}">
                            <input type="hidden" id="amount" name="amount" class="form-control" value="40">
                        </div>
                        <button type="submit" class="btn btn-primary">Click here to pay</button>

                    </form>
                </div>
            </div>
        </div>
    </div>


</div>



    <script>

    document.querySelectorAll('input[readonly]').forEach((input) => {
        input.addEventListener('input', () => {
            alert('Unauthorized modification detected!');
            input.value = input.getAttribute('data-original-value'); // Reset to original value
        });
    });

    function useCustomContact(radioId) {
        var contactRequiredArray = '{$requiredArray}';
        const parentTabPane = document.getElementById(radioId).closest('.tab-pane');
        if (parentTabPane) {
            const inputs = parentTabPane.querySelectorAll('input');
            inputs.forEach((input) => {
                const label = input.closest('.form-group')?.querySelector('label')?.textContent?.trim();
                if (!contactRequiredArray.includes(label)) {
                    input.removeAttribute('readonly');
                } else {
                    input.setAttribute('readonly');
                }
            });
        }
    }
    </script>
