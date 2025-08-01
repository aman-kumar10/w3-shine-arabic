
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="{$charset}" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$companyname} - {$pagetitle}</title>

    <link href="{assetPath file='all.min.css'}?v={$versionHash}" rel="stylesheet">
    <link href="{assetPath file='theme.min.css'}?v={$versionHash}" rel="stylesheet">
    <link href="{$WEB_ROOT}/assets/css/fontawesome-all.min.css" rel="stylesheet">
    <link href="{assetPath file='invoice.min.css'}?v={$versionHash}" rel="stylesheet">
    <script>
        var whmcsBaseUrl = "{$WEB_ROOT}";
    </script>
    <script src="{assetPath file='scripts.min.js'}?v={$versionHash}"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            font-size: 12px;
        }
        hr.hr-class {
            margin-top: 0;
        }

        .header-content {
            padding-bottom: 0;
        }
        .row.invoice-header.table-responsive {
            align-items: center;
        }
        .invoice-container {
            max-width: 800px;
            margin: 0 auto;
            border: 1px solid #ccc;
        }

        .header-content {
            display: inline-block;
            padding: 15px 0px;
            width:100%;
        }

        .logo {
            width: 190px;
            height: 70px;
        }

        .support-text {
            color: #201b4f;
            font-size: 11px;
            margin-left: 20px;
                text-align: right;
        }
        .invoice-header {
            display: flex;
            justify-content: space-between;
            /* margin-bottom: 20px; */
        }
        select.custom-select {
            margin-top: 10px;
        }

        .bill-to {
            border: 1px solid #ccc;
            padding: 10px;
            width: 30%;
        }

        .invoice-title {
            text-align: right;

        }

        .customer-details {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .customer-details td {
            border: 1px solid #ccc;
            padding: 5px;
            font-size: 11px;
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 0px;
        }

        .items-table th,
        .items-table td {
            border: 1px solid #828282;
            padding: 5px;
            text-align: left;
            font-size: 11px;
        }

        .items-table th {
            background-color: #cdcdcd;
        }

        .totals-section {
            width: 100%;
            border-collapse: collapse;
        }

        .totals-section td {
            border: 1px solid #828282;
            padding: 5px;
            font-size: 11px;
        }

        .totals {
            float: right;
            width: 35%;
        }

        .signatures {
            padding-top: 30px;
        }

        .signature-box {
            text-align: center;
            width: 150px;
        }

        .signature-line {
            margin-top: 20px;
        }

        .footer {
            clear: both;
            text-align: center;
            font-size: 10px;
            padding: 20px;
            border-top: 1px solid #ccc;
        }

        .footer-band {
            background: linear-gradient(to right, #00a0e3, #0086bf);
            height: 10px;
        }

        .footer-logo {
            text-align: right;
            padding: 10px;
        }

        .footer-logo img {
            width: 100px;
        }

        .arabic {
            font-size: 10px;
            color: #666;
        }

        .generated-text {
            text-align: center;
            font-size: 10px;
            color: #666;
            padding: 5px 0;
            border-top: 1px solid #ccc;
        }

        .bill-table {
            border: 1px solid #828282;
            width: 144px;
            font-family: Arial, sans-serif;
        }

        .bill-table td {
            padding: 4px 8px;
            line-height: 1.2;
        }

        .bill-title {
            border-bottom: 1px solid #828282;
            font-weight: bold;
            background-color: #cdcdcd;
        }

        .invoice-title p {
            font-size: 12px;
        }

        .hr-class {
            width: 100%;
            background-color: #0098d8;
            border: 1px solid #0098d8;
        }

        .logo_header {
            width: 100%;
            padding-top: 5px;
        }
        .logo-container, .support-text {
            width: 100%;
            max-width: 48%;
            display: inline-block;
        }
        .ptag {
            font-size: 11px;
            COLOR: #2da4e8;
            text-align: right;
        }
        .ptag p {
            margin-bottom: 0;
            text-align: right;
        }
        .stamp {
            width: 100%;
            max-width: 90px;
        }

        h2.invoice strong {
            color: #0000007a;
            font-size: 45px;
            display: block;
            text-align: right;
        }

        table.customer-details.table-responsive tbody tr td {
            width: 10%;
        }
        .support-text h3 {
            font-size: 14px;
        }

        .custom-print {
            margin-bottom: 20px;
        }

        .bill-to {
            width: 240px;
            border: 1px solid #6666;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
        }

        .bill-to th {
            background-color: #e0e0e0;
            text-align: left;
            padding: 5px;
            font-size: 14px;
            border-bottom: 1px solid #6666
        }

        .bill-to td {
            padding: 5px;
            font-size: 13px;
        }

        .bill-to th span {
            float: right;
            font-size: 12px;
            color: #666;
        }
        .table thead th {
            vertical-align: middle;
            border-bottom: unset;
            text-align: center;
        }

        .total-wid {
            width: 82%;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0px 0px;
            font-family: Arial, sans-serif;
            width: 65%;
        }

        .date-time {
            font-size: 12px;
            color: #333;
        }

        .invoice-link {
            font-size: 12px;
            color: #1a73e8;
            text-decoration: none;
        }

        .invoice-link:hover {
            text-decoration: underline;
        }
        .col-md-9.col-sm-12.table-responsive.sub-totale-tbl-main {
               padding-right: 0;
                width: 100%;
                max-width: 69%;
                display: inline-block;
                padding-left: 0;
        }
        .sub-totale-wrapper {
            display: inline-block;
            width: 100%;
            text-align: right;
            vertical-align: middle;
        }
        .transactions-container.small-text {
            margin-top: -5px;
        }
        .sub-totale-wrapper .col-md-3.col-sm-12 {
            width: 100%;
            max-width: 30%;
            display: inline-block;
            text-align: left;
        }
        .row.sub-totale-wrapper {
            align-items: center;
        }
        .row.sub-totale-wrapper .col-md-3.col-sm-12 {
            padding: 0;
        }
        .row.invoice-header.table-responsive {
            display: inline-block;
            width: 100%;
        }

        .invoice-header .col-md-5.col-sm-12 {
            max-width: 41.6666666667%;
            width: 100%;
            display: inline-block;
        }

        .invoice-header .col-md-3.col-sm-12 {
            width: 100%;
            max-width: 25%;
            display: inline-block;
        }

        .invoice-header .col-md-4.col-sm-12.custom-invoice {
            width: 100%;
            display: inline-block;
            max-width: 31%;
        }
        @media (max-width: 767px){
            .header-content {
                display: block;
            }
            .support-text h3 {
                font-size: 12px;
            }
            .support-text {
                margin-left: 0;
            }
            .ptag {
                margin-left: 0;
                justify-content: left;
                text-align: left;
            }
            .invoice-container{
                padding: 15px;
            }
            .header {
                width: 100%;
            }
            .bill-to {
                width: 100%;
            }
            .invoice-title {
                text-align: left;
            }
            h2.invoice strong {
                color: #0000007a;
                font-size: 24px;
                margin-top: 15px;
                display: block;
                text-align: center;
            }
            .invoice-container .payment-btn-container{
                text-align: left;
            }
            .container.invoice-content {
                padding: 0;
            }
            .invoice-container .payment-btn-container {
                margin-top: 5px;
                text-align: left !important;
            }
            .row.sub-totale-wrapper p {
                margin: 10px 0px !important;
            }
            .signatures .col-md-6.col-12.text-right {
                text-align: left !important;
                margin-top: 20px;
            }
            /*.sub-totale-wrapper .col-md-3.col-sm-12, .col-md-9.col-sm-12.table-responsive.sub-totale-tbl-main {
                max-width: 100%;
            }*/
        }
    </style>
</head>

<body>

    <div class="container">
        {if $invalidInvoiceIdRequested}

            {include file="$template/includes/panel.tpl" type="danger" headerTitle="{lang key='error'}"
            bodyContent="{lang key='invoiceserror'}" bodyTextCenter=true}

        {else}

            <div class="invoice-container">
                <div class="header">
                    <span class="date-time">{$generatedDate}</span>
                    Routedge Invoice
                </div>


                <div class="header-band"><img src="{$WEB_ROOT}/templates/w3infotech/images/header_line.png" alt="Routedge"
                        class="logo_header"></div>
                <div class="header-content">
                    <div class="logo-container"><a href="https://w3.shinedezign.pro/" target="_blank">
                            <img src="{$WEB_ROOT}/templates/w3infotech/images/logo_w3.png" alt="Routedge" class="logo"></a>
                            <p class="domainptag" style="color:#2da4e8; font-size:11px; margin-left:20px;">Register: .qa .قطر .com.qa
                    .net.qa .name.qa</p>
                    </div>
                    <div class="support-text">
                        <h3><b>Sales & Support: +974-66-703-103</b></h3>
                        <div class="ptag">
                            <p>Domain Name Registration</p>
                            <p>LINUX / WindowsWeb Hosting</p>
                            <p>Cloud Email Hosting Services</p>
                        </div>
                    </div>
                </div>
                
                <hr class="hr-class" />




                <div class="containers invoice-content">
                    <div class="row invoice-header table-responsive">
                        <div class="col-md-5 col-sm-12">
                            <table class="bill-to">
                                <thead>
                                    <tr>
                                        <th>
                                            Bill To
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            {if $clientsdetails.companyname}{$clientsdetails.companyname}<br />{/if}
                                            {$clientsdetails.firstname} {$clientsdetails.lastname}<br />
                                            {$clientsdetails.address1}, {$clientsdetails.address2}<br />
                                            {$clientsdetails.city}, {$clientsdetails.state},
                                            {$clientsdetails.postcode}<br />
                                            {$clientsdetails.country}
                                            {if $clientsdetails.tax_id}
                                                <br />{$taxIdLabel}: {$clientsdetails.tax_id}
                                            {/if}
                                            {if $customfields}
                                                <br /><br />
                                                {foreach $customfields as $customfield}
                                                    {$customfield.fieldname}: {$customfield.value}<br />
                                                {/foreach}
                                            {/if}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-3 col-sm-12">
                            <strong>{lang key='paymentmethod'}</strong><br>
                            <span class="small-text" data-role="paymethod-info">
                                {if $status eq "Unpaid" && $allowchangegateway}
                                    <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}"
                                        class="form-inline">
                                        {$tokenInput}
                                        <select name="gateway" class="custom-select" onchange="submit()">
                                            {foreach $availableGateways as $gatewayModule => $gatewayName}
                                                <option value="{$gatewayModule}" {if $gatewayModule == $selectedGateway}
                                                    selected="selected" {/if}>{$gatewayName}</option>
                                            {/foreach}
                                        </select>
                                    </form>
                                {else}
                                    {$paymentmethod}{if $paymethoddisplayname} ({$paymethoddisplayname}){/if}
                                {/if}
                            </span>
                            <br /><br />
                        </div>                   

                        <div class="col-md-4 col-sm-12 custom-invoice">
                            <div class="invoice-title text-md-end text-sm-start">
                                <h2 class="invoice"><strong>INVOICE</strong></h2>
                                <div class="invoice-status">
                                    {if $status eq "Draft"}
                                        <span class="draft">{lang key='invoicesdraft'}</span>
                                    {elseif $status eq "Unpaid"}
                                        <span class="unpaid">{lang key='invoicesunpaid'}</span>
                                    {elseif $status eq "Paid"}
                                        <span class="paid">{lang key='invoicespaid'}</span>
                                    {elseif $status eq "Refunded"}
                                        <span class="refunded">{lang key='invoicesrefunded'}</span>
                                    {elseif $status eq "Cancelled"}
                                        <span class="cancelled">{lang key='invoicescancelled'}</span>
                                    {elseif $status eq "Collections"}
                                        <span class="collections">{lang key='invoicescollections'}</span>
                                    {elseif $status eq "Payment Pending"}
                                        <span class="paid">{lang key='invoicesPaymentPending'}</span>
                                    {/if}
                                </div>

                                {if $status eq "Unpaid" || $status eq "Draft"}
                                    <div class="small-text">
                                        {lang key='invoicesdatedue'}: {$datedue}
                                    </div>
                                    <div class="payment-btn-container d-print-none" align="center" style="text-align: right;">
                                        {$paymentbutton}
                                    </div>
                                {/if}

                            </div>
                        </div>

                    </div>

                        <div class="table-responsive">
                            <table border="1" cellspacing="0" cellpadding="5" class="table table-sm table items-table">
                                <thead>
                                    <tr>
                                        <th>#SNo</th>
                                        <th>Product Code</th>
                                        <th>Description</th>
                                        <th>Duration</th>
                                        <th>Quantity</th>
                                        <th>Unit Price</th>
                                        <th>Discount</th>
                                        <th>Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach  $cusInvoiceItemsData as $index => $item}

                                        <tr>
                                            <td>{$index + 1}</td>
                                            <td>{$item.invoiceid}</td>
                                            <td>{$item.description}{if $item.taxed eq "true"} *{/if}</td>
                                            <td>{$item.duration}</td>
                                            <td>{$item.Quantity}</td>
                                            <td>{$item.amount}</td>
                                            <td>{$item.total}</td>
                                            <td>{$item.amount}</td>
                                        </tr>
                                    {/foreach}

                                </tbody>
                            </table>
                        </div>
                        <div class="containers table-responsive">
                            <div class="sub-totale-wrapper">
                                <div class="col-md-3 col-sm-12">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td colspan="2" rowspan="5">
                                                    <p style="font-size: 9px;margin-bottom: 0;">
                                                        Account Name: Routedge Company<br>
                                                        Account Number: 0850020630001<br>
                                                        IBAN Account Number: QA07QNBA000000000850020630001<br>
                                                        Bank: QNB<br>
                                                        Branch: Corporate Branch<br>
                                                        SWIFT Code: QNBAQAQA
                                                    </p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-md-9 col-sm-12 table-responsive sub-totale-tbl-main">
                                    <table border="1" cellspacing="0" cellpadding="5"
                                        class="table items-table sub-total-details">
                                        <tbody>
                                            <tr>
                                                <td class="total-row text-left total-wid"><strong>Subtotal</strong></td>
                                                <td class="total-row text-right">{$subtotal}</td>
                                            </tr>
                                            <tr>
                                                <td class="total-row text-left total-wid"><strong>Total Invoice
                                                        Amount</strong></td>
                                                <td class="total-row text-right">{$subtotal}</td>
                                            </tr>
                                            {if $taxname}
                                                <tr>
                                                    <td class="total-row text-left total-wid"><strong>{$taxrate}%
                                                            {$taxname}</strong></td>
                                                    <td class="total-row text-right">{$tax}</td>
                                                </tr>
                                            {/if}
                                            {if $taxname2}
                                                <tr>
                                                    <td class="total-row text-left"><strong>{$taxrate2}% {$taxname2}</strong>
                                                    </td>
                                                    <td class="total-row text-right">{$tax2}</td>
                                                </tr>
                                            {/if}
                                            <tr>
                                                <td class="total-row text-left"><strong>Payment/Credit Applied</strong></td>
                                                <td class="total-row text-right">{$credit}</td>
                                            </tr>
                                            <tr>
                                                <td class="total-row text-left"><strong>{lang key='invoicestotal'}</strong>
                                                </td>
                                                <td class="total-row text-right">{$total}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>



                        <div class="transactions-container small-text">
                            <div class="table-responsive">
                                <table class="table table-sm table items-table">
                                    <thead>
                                        <tr>
                                            <td class="text-center"><strong>{lang key='invoicestransdate'}</strong></td>
                                            <td class="text-center"><strong>{lang key='invoicestransgateway'}</strong></td>
                                            <td class="text-center"><strong>{lang key='invoicestransid'}</strong></td>
                                            <td class="text-center"><strong>{lang key='invoicestransamount'}</strong></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach $transactions as $transaction}
                                            <tr>
                                                <td class="text-center">{$transaction.date}</td>
                                                <td class="text-center">{$transaction.gateway}</td>
                                                <td class="text-center">{$transaction.transid}</td>
                                                <td class="text-center">{$transaction.amount}</td>
                                            </tr>
                                        {foreachelse}
                                            <tr>
                                                <td class="text-center" colspan="4">{lang key='invoicestransnonefound'}</td>
                                            </tr>
                                        {/foreach}
                                        <tr>
                                            <td class="text-right" colspan="3"><strong>{lang key='invoicesbalance'}</strong>
                                            </td>
                                            <td class="text-center">{$balance}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>




                        <div class="signatures">
                            <div class="row">
                                <!-- Accountant Signature -->
                                <div class="col-md-6 col-12 text-left">
                                    <strong>Accountant:</strong>
                                    <div class="signature-line">
                                        <img src="{$WEB_ROOT}/templates/w3infotech/images/w3stamp.png" alt="Routedge" class="stamp img-fluid">
                                    </div>
                                </div>

                                <!-- Received By Signature -->
                                <div class="col-md-6 col-12 text-right">
                                    <strong>Received By:</strong>
                                    <div class="signature-line"></div>
                                </div>
                            </div>
                        </div>


                    <div class="table-responsive">
                    <table class="float-right btn-group btn-group-sm d-print-none custom-print">
                    <tbody>
                    <tr>

                    <td><a href="javascript:window.print()" class="btn btn-default"><i class="fas fa-print"></i> {lang key='print'}</a></td>

                    <td><a href="dl.php?type=i&amp;id={$invoiceid}" class="btn btn-default"><i class="fas fa-download"></i> {lang key='invoicesdownload'}</a></td>

                    {if $status eq "Paid"}
                        <td><a href="payment-slip.php?invoiceid={$invoiceid}" class="btn btn-default"><i class="fas fa-download"></i> Payment Slip</a></td>
                    {/if}

                    </tr>
                    </tbody>
                    </table>
                    </div>
                    

                    <div class="footers table-responsive">

                        <table style="width: 100%; border-collapse: collapse; text-align: center; font-family: Arial, sans-serif;">
                            <tr>
                                <td colspan="2" style="font-style: italic; color: gray; font-size:10px;">
                                    This is a computer generated invoice and no signature is required.
                                    <p style="border: none; border-top: 1px solid #3d8edf;"></p>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 70%; text-align: left;">
                                    <strong style="color:#205873; font-size:25px;">ROUTEDGE <span
                                            style="color:#205873; font-size:9px;"> W.L.L</span></strong>
                                    <p style="font-size:9px; color: #2da4e8;">
                                        PO Box: 31496, Doha, State of Qatar <br>
                                        Tel: +974-4434-3721, +974-4443-31-22 Fax: +974-444-12-731 Sales & Support:
                                        +974-66-703-103 <br>
                                        Email: info@routedge.com | www.routedge.com</p>
                                    <strong style="color:#2f3193;">Domain Registration Portal:</strong> <a
                                        href="http://www.routedge.net.qa" target="_blank"
                                        style="text-decoration: none; color:#2f3193;">www.routedge.net.qa</a>
                                </td>
                                <td style="width: 30%; text-align: center;">
                                    <center><img src="{$WEB_ROOT}/templates/w3infotech/images/logo_w3.png"
                                            alt="Company Logo" style="width: 80%;"></center>
                                    <p style="color:#2d2859;"><b>Brandable Domains Forever!</b></p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <img src="{$WEB_ROOT}/templates/w3infotech/images/header_line.png" alt="Border"
                                        style="width: 100%;">
                                </td>

                            </tr>
                        </table>
                    </div>
                {/if}
               
                <p class="text-center d-print-none"><a href="clientarea.php?action=invoices">{lang key='invoicesbacktoclientarea'}</a></p>

               
            </div>
</body>

</html>