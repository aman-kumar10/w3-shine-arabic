<?php

use WHMCS\Database\Capsule;

use WHMCS\Module\Addon\ManageDns\Helper;


if (!defined("WHMCS")) {
    die("This file cannot be accessed directly");
}

add_hook('ClientAreaFooterOutput', 1, function ($vars) {


    try {


        if ((Capsule::table('tbladdonmodules')->where('module', 'manage_dns')->count() > 0) && ($vars['templatefile'] == "clientareadomaindetails") && ($_SESSION['uid'])) {


            global $whmcs, $CONFIG;

            $helper = new Helper();

            $helper->CreateCustomTable();

            $systemURL = $CONFIG['SystemURL'];

            $userid = $_SESSION['uid'];


            $domainId = $whmcs->get_req_var('id');

            if (!empty($whmcs->get_req_var('dnsaction')) && $whmcs->get_req_var('dnsaction') == 'subscribe') {

                $currencyid = getCurrency($userid);

                $domaindata = $helper->getDomainData($whmcs->get_req_var('domainid'), $userid);

                $price = Capsule::table('tblpricing')->where('type', 'domainaddons')->where('relid', 0)->where('currency', $currencyid['id'])->value('msetupfee');

                $command = 'CreateInvoice';
                $postData = array(
                    'userid' => $userid,
                    'status' => 'Unpaid',
                    'sendinvoice' => '1',
                    // 'taxrate' => '10.00',
                    'date' => date('Y-m-d'),
                    'duedate' => date('Y-m-d', strtotime('+10 days')),
                    'itemdescription1' => 'DNS Management (' . $domaindata->domain . ')',
                    'itemamount1' => $price,
                    'autoapplycredit' => '0',
                );

                $results = localAPI($command, $postData);

                if ($results['result'] == "success") {

                    $helper->insertDomainData($userid, $whmcs->get_req_var('domainid'), $results['invoiceid'], $results['status'], '1');
                    $result = ["result" => $results['result'], "invoiceid" => $results['invoiceid']];
                    echo json_encode($result);
                    die;
                } else {

                    logModuleCall('manage dns addons', 'DomaindnsService', '', '', $results);
                }
            }

            $domaindata = $helper->getDomainData($domainId, $userid);



            $getinvoicedata = $helper->getCustromTableData($domainId, $userid);

            $invoicestatus = "";

            if (!empty($getinvoicedata)) {
                $invoiceStatusFromDB = Capsule::table('mod_dns_management')
                    ->where('invoiceid', $getinvoicedata->invoiceid)
                    ->where('dnsmanagement', '1')
                    ->value('invoicestatus');

                if ($invoiceStatusFromDB === "Paid") {
                    $invoicestatus = "Paid";
                } else if ($invoiceStatusFromDB === "Unpaid") {
                    $invoicestatus = "Unpaid";
                }
            }

            $checkextenstionstatus = false;

            $domainextension = $domaindata->domain;

            if (!empty($domainextension)) {
                $domainextenstionname = $helper->getDomainExtension($domainextension);


                $dnsstatus = Capsule::table('tbldomainpricing')->where('extension', $domainextenstionname)->value('dnsmanagement');

                if ($dnsstatus == 1) {
                    $checkextenstionstatus = true;
                }
            }

            $urlId = isset($domainId) ? htmlspecialchars($domainId, ENT_QUOTES, 'UTF-8') : '';



            if ($vars["filename"] == "clientarea" && isset($domainId) && $whmcs->get_req_var("action") == "domaindetails" && $domaindata->status == "Active" && $invoicestatus == 'Paid') {



                $path = $systemURL . "/index.php?m=manage_dns&domain=" . $urlId;


                $appendHtml = '
                            <a menuitemname="SUBCRIBE DNS MANGEMENT" href="' . htmlspecialchars($path, ENT_QUOTES, 'UTF-8') . '"
                            class="list-group-item list-group-item-action" id="Secondary_Sidebar-My_Domains_Actions-Manage_DNS">
                                <div class="sidebar-menu-item-wrapper">
                                    <div class="sidebar-menu-item-label">
                                        ADD DNS Record
                                    </div>
                                </div>
                            </a>';


                $escapedAppendHtml = json_encode($appendHtml);

                $html = "
                <script type=\"text/javascript\">
                    $(document).ready(function(){
                        $('[menuitemname=\"Domain Details Management\"] .list-group.list-group-flush.d-md-flex').append(" . $escapedAppendHtml . ");
                    });
                </script>";

                return $html;
            } elseif ($vars["filename"] == "clientarea" && isset($domainId) && $whmcs->get_req_var("action") == "domaindetails" && $domaindata->status == "Active" && $invoicestatus == "" && $checkextenstionstatus) {

                $appendHtml = '
                <button menuitemname="Manage DNS" 
                        class="list-group-item list-group-item-action" 
                        id="Secondary_Sidebar-Manage_DNS_Service" 
                        data-dns-action="subscribe"
                        data-dns-domainid="' . $domainId . '" data-dns-sysurl="' . $systemURL . '">
                    <div class="sidebar-menu-item-wrapper">              
                        <div class="sidebar-menu-item-label">
                            SUBCRIBE DNS MANGEMENT
                        </div>
                    </div>
                </button>';


                // Use json_encode to safely escape the HTML content for JavaScript
                $escapedAppendHtml = json_encode($appendHtml);
                // JavaScript to inject into the footer

                $html = "
                    <script type=\"text/javascript\">
                        $(document).ready(function(){
                            $('[menuitemname=\"Domain Details Management\"] .list-group.list-group-flush.d-md-flex').append(" . $escapedAppendHtml . ");
                        });

                        $(document).on('click', '#Secondary_Sidebar-Manage_DNS_Service', function(event) {

                            event.preventDefault();
                            $(this).prop('disabled', true);
                            var dnssubscription = $(this).data('dns-action');  
                            var domainId = $(this).data('dns-domainid');  
                            

                            $.ajax({
                                url: '',  
                                type: 'POST',
                                data: {
                                    dnsaction: dnssubscription,  
                                    domainid: domainId     
                                },
                                success: function(data) {
                                $(this).prop('disabled', false);
                                    let response = JSON.parse(data);

                                    if (response.result === 'success') {
                                        
                                        window.location.href = '{$systemURL}/viewinvoice.php?id=' + response.invoiceid;
                                    }
                                }
                            });
                        });
                    </script>";

                return $html;
            } elseif ($vars["filename"] == "clientarea" && isset($domainId) && $whmcs->get_req_var("action") == "domaindetails" && $domaindata->status == "Active" && $invoicestatus == "Unpaid") {

                $path = $systemURL . "/viewinvoice.php?id=" . $getinvoicedata->invoiceid;


                $appendHtml = '
                            <a menuitemname="SUBCRIBE DNS MANGEMENT" href="' . htmlspecialchars($path, ENT_QUOTES, 'UTF-8') . '"
                            class="list-group-item list-group-item-action" id="Secondary_Sidebar-My_Domains_Actions-Manage_DNS">
                                <div class="sidebar-menu-item-wrapper">
                                    <div class="sidebar-menu-item-icon-wrapper">
                                        <i class="fa fa-server"></i>
                                    </div>
                                    <div class="sidebar-menu-item-label">
                                        SUBCRIBE DNS MANGEMENT
                                    </div>
                                </div>
                            </a>';

                // Use json_encode to safely escape the HTML content for JavaScript
                $escapedAppendHtml = json_encode($appendHtml);
                // JavaScript to inject into the footer
                $html = "
                <script type=\"text/javascript\">
                    $(document).ready(function(){
                        $('[menuitemname=\"Domain Details Management\"] .list-group.list-group-flush.d-md-flex').append(" . $escapedAppendHtml . ");
                    });
                </script>";

                return $html;
            }
        }
    } catch (\Exception $e) {
        logActivity("dnsmanager Hook: " . $e->getMessage());
    }
});

add_hook('AfterShoppingCartCheckout', 1, function ($vars) {


    $helper = new Helper();

    $userid = $_SESSION['uid'];

    if (!$userid) {
        $userid = Capsule::table('tbldomains')->where('orderid', $vars['OrderID'])->value('userid');
    }


    if ($userid) {

        $helper->CreateCustomTable();

        foreach ($vars['DomainIDs'] as $key => $value) {

            if (Capsule::table('tbldomains')->where('id', $value)->where('userid', $userid)->where('type', 'Register')->where('dnsmanagement', 1)->count()) {

                $domiandata = $helper->getDomainData($value, $userid);

                $invoice = Capsule::table('tblinvoices')->where('id', $vars['InvoiceID'])->first();
                
                $result = $helper->insertDomainData($userid, $value, $vars['InvoiceID'], $invoice->status, $domiandata->dnsmanagement);

                if ($result == 1 && $invoice->status == 'Paid') {

                    $helper->CreateDomaindnsService($value, $userid);
                }
            }
        }
    }
});

add_hook('InvoicePaid', 1, function ($vars) {

    $helper = new Helper();


    if (Capsule::table('mod_dns_management')->where('invoiceid', $vars['invoiceid'])->where('invoicestatus', 'Unpaid')->count() > 0 && ($_SESSION['uid'])) {


        $domaindata = Capsule::table('mod_dns_management')->where('invoiceid', $vars['invoiceid'])->first();

        Capsule::table('mod_dns_management')->where('invoiceid', $vars['invoiceid'])->update(['invoicestatus' => 'Paid']);

        $helper->CreateDomaindnsService($domaindata->domianid, $_SESSION['uid']);

    }
});

add_hook('AfterRegistrarRequestDelete', 1, function ($vars) {

    $helper = new Helper();
    $helper->deleteDomaindnsService($vars['params']['domainid'], $vars['params']['userid']);
});
