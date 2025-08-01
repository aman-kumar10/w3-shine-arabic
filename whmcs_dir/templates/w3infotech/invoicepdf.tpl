<?php

use WHMCS\Database\Capsule;

// $invoicedatehead = "";
// foreach ($invoiceitems as $index => $items) {
//     $invoiceDate = Capsule::table('tblinvoices')->where('id', $items['relid'])->value('created_at');
//     $formattedDate = (new DateTime($invoiceDate))->format('m/d/y, g:i A');
//     $invoicedatehead = $formattedDate;
// }
// Get the current date and time in IST
$datetime = new DateTime('now', new DateTimeZone('Asia/Kolkata'));
$generatedDate = $datetime->format('d/m/y, g:i A');



$pdf->SetXY(5, 4); // Set X and Y for the address, right side of the page
$pdf->SetFont('Roboto', '', 7);
$pdf->Cell(31, 4, $generatedDate, 0, 1, 'R');
$pdf->SetTextColor(0, 0, 0);


$pdf->SetXY(5, 4); // Set X and Y for the address, right side of the page
$pdf->SetFont('Roboto', '', 7);
$pdf->Cell(120, 4, 'Routedge Invoice', 0, 1, 'R');
$pdf->SetTextColor(0, 0, 0);

# Logo
$logoFilename = 'placeholder.png';
if (file_exists(ROOTDIR . '/templates/w3infotech/images/header_line.png')) {
    $logoFilename = 'header_line.png';
} elseif (file_exists(ROOTDIR . '/templates/w3infotech/images/header_line.jpg')) {
    $logoFilename = 'header_line.jpg';
} elseif (file_exists(ROOTDIR . '/templates/w3infotech/images/header_line.jpeg')) {
    $logoFilename = 'header_line.jpeg';
}
// Add an image to the PDF
$pdf->Image(ROOTDIR . '/templates/w3infotech/images/' . $logoFilename, 15, 10, 180, 2, '', '', '', false, 300, '', false, false, 0);

$pdf->SetXY(150, 12); // Set X and Y for the address, right side of the page
$pdf->SetFont('Roboto', 'B', 10);
$pdf->SetTextColor(32, 27, 79);
$pdf->Cell(0, 15, 'Sales & Support : +974-66-703-103', 0, 1, 'R');
$pdf->SetTextColor(0, 0, 0);

$pdf->SetXY(150, 16); // Set X and Y for the address, right side of the page
$pdf->SetFont('Roboto', '', 7);
$pdf->SetTextColor(23, 121, 207);
$pdf->Cell(0, 15, 'Domain Name Registration', 0, 1, 'R');
$pdf->SetTextColor(0, 0, 0);

$pdf->SetXY(150, 20); // Set X and Y for the address, right side of the page
$pdf->SetFont('Roboto', '', 7);
$pdf->SetTextColor(23, 121, 207);
$pdf->Cell(0, 15, 'LINUX / WindowsWeb Hosting', 0, 1, 'R');
$pdf->SetTextColor(0, 0, 0);

$pdf->SetXY(150, 24); // Set X and Y for the address, right side of the page
$pdf->SetFont('Roboto', '', 7);
$pdf->SetTextColor(23, 121, 207);
$pdf->Cell(0, 15, 'Cloud Email Hosting Services', 0, 1, 'R');
$pdf->SetTextColor(0, 0, 0);

# Logo
$logoFilename = 'placeholder.png';
if (file_exists(ROOTDIR . '/templates/w3infotech/images/logo_w3.png')) {
    $logoFilename = 'logo_w3.png';
} elseif (file_exists(ROOTDIR . '/templates/w3infotech/images/logo_w3.jpg')) {
    $logoFilename = 'logo_w3.jpg';
} elseif (file_exists(ROOTDIR . '/templates/w3infotech/images/logo_w3.jpeg')) {
    $logoFilename = 'logo_w3.jpeg';
}
// Add an image to the PDF
$pdf->Image(ROOTDIR . '/templates/w3infotech/images/' . $logoFilename, 15, 18, 50, 15, '', '', '', false, 300, '', false, false, 0);


$pdf->SetXY(15, 30);
$pdf->SetTextColor(23, 121, 207);
$pdf->SetFont('Roboto', '', 6);
$pdf->Cell(0, 10, 'Register: .qa .com.qa .net.qa .name.qa', 0, 1, 'L');
$pdf->SetTextColor(0, 0, 0);


$pdf->SetXY(0, 0);
$pdf->SetXY(40, 33);

$pdf->SetDrawColor(44, 144, 206); 
$pdf->Line(15, $pdf->GetY() + 5, 195, $pdf->GetY() + 5);


$pdf->SetXY(0, 0);

$startpage = $pdf->GetPage();
$pdf->Ln(5);

// Invoice Title
$pdf->SetXY(15, 40);
$pdf->SetX(15, 47);
$pdf->SetFont('Roboto', 'B', 35);
$pdf->SetTextColor(130, 130, 130);
$pdf->Cell(180, 10, 'INVOICE', 0, 1, 'R');

$pdf->SetTextColor(0, 0, 0);

// Invoice Details Box
$pdf->SetX(145, 20);
$pdf->SetFont('Roboto', '', 7);
$pdf->Cell(35, 4, 'Invoice Number' . '', 0, 0, 'L');
$pdf->SetFont('Roboto', '', 7);
$pdf->Cell(15, 4, ': ' . $invoicenum, 0, 1, 'L');


$cusDatecreated = DateTime::createFromFormat('d/m/Y', $datecreated)->format('M d Y');


$pdf->SetX(145, 75);
$pdf->SetFont('Roboto', '', 7);
$pdf->Cell(35, 4, 'Invoice Date' . '', 0, 0, 'L');
$pdf->SetFont('Roboto', '', 7);
$pdf->Cell(15, 4, ': ' . $cusDatecreated, 0, 1, 'L');


// Set X position
$pdf->SetX(145);
$pdf->SetFont('Roboto', '', 7);

// Output the label for the status (without color change)
$pdf->Cell(35, 4, 'Invoice Status' . '', 0, 0, 'L');

// Check the invoice status and set color accordingly for the status text
if (strtolower($status) === 'unpaid') {
    $pdf->SetTextColor(255, 0, 0); // Red color for unpaid
} elseif (strtolower($status) === 'paid') {
    $pdf->SetTextColor(75, 181, 67); // Green color for paid
} else {
    $pdf->SetTextColor(0, 0, 0); // Default color (black) for other statuses
}

// Output the status with the set color
$pdf->Cell(15, 4, ': ' . Lang::trans('invoices' . strtolower($status)), 0, 1, 'L');


// Reset color to default for subsequent text
$pdf->SetTextColor(0, 0, 0); // Reset to black for any following text


$pdf->SetX(145, 85);
$pdf->SetFont('Roboto', '', 7);
$pdf->Cell(35, 4, Lang::trans('page') . '', 0, 0, 'L');
$pdf->SetFont('Roboto', '', 7);
$pdf->Cell(15, 4, ': ' . $pdf->PageNo(), 0, 1, 'L');


# Clients Details
// Set the background color for the "Bill To" section header
$pdf->SetFillColor(205, 205, 205);
$pdf->SetDrawColor(120);
$pdf->SetLineWidth(0.20); // Light gray

$pdf->SetY(45);
$pdf->SetFont($pdfFont, '', 9); // Adjust font size for "Bill To"
$pdf->Cell(70, 8, 'Bill To', 1, 1, 'L', true); // Keep the full border for the header

// Define the table dimensions for client details
$pdf->SetFont($pdfFont, '', 7);
$tableWidth = 70;  // Width of the table
$cellHeight = 4;   // Height of each cell

// Draw client's company name if available, else client's name
if ($clientsdetails["companyname"]) {
    // Company name without bottom border
    $pdf->Cell($tableWidth, $cellHeight, $clientsdetails["companyname"], 'LR', 1, 'L'); // No bottom border
    // Attention line with border
    $pdf->Cell($tableWidth, $cellHeight, Lang::trans('invoicesattn') . ': ' . $clientsdetails["firstname"] . ' ' . $clientsdetails["lastname"], 'LR', 1, 'L');
} else {
    // Client's full name without bottom border
    $pdf->Cell($tableWidth, $cellHeight, $clientsdetails["firstname"] . " " . $clientsdetails["lastname"], 'LR', 1, 'L'); // No bottom border
}

// Address with standard borders
$pdf->Cell($tableWidth, $cellHeight, $clientsdetails["address1"], 'LR', 1, 'L');
if ($clientsdetails["address2"]) {
    $pdf->Cell($tableWidth, $cellHeight, $clientsdetails["address2"], 'LR', 1, 'L');
}
$pdf->Cell($tableWidth, $cellHeight, $clientsdetails["city"] . ", " . $clientsdetails["state"] . ", " . $clientsdetails["postcode"], 'LR', 1, 'L');
$pdf->Cell($tableWidth, $cellHeight, $clientsdetails["country"], 'LRB', 1, 'L');

// Tax ID, if present
if (array_key_exists('tax_id', $clientsdetails) && $clientsdetails['tax_id']) {
    $pdf->Cell($tableWidth, $cellHeight, $taxIdLabel . ': ' . $clientsdetails['tax_id'], 'LR', 1, 'L');
}

// Custom fields
if ($customfields) {
    $pdf->Ln();
    foreach ($customfields as $customfield) {
        $pdf->Cell($tableWidth, $cellHeight, $customfield['fieldname'] . ': ' . $customfield['value'], 1, 1, 'L');
    }
}

$pdf->Ln(5);


$pdf->SetFont('helvetica', '', 8); 

// $pdf->Image(ROOTDIR . '/assets/img/' . $logoFilename, 5, 70, 530, 199, '', '', '', false, 300, '', false, false, 0);
$currency_code = Capsule::table('tblcurrencies')->where('id', $clientsdetails['currency'])->value('code');

$pay_type = "";
foreach ($invoiceitems as $index => $items) {
    $invoiceDate = Capsule::table('tblinvoices')->where('id', $items['relid'])->value('created_at');

    

    $details = Capsule::table('tblhosting')->where('id', $items['relid'])->first();

    $pay_type = Capsule::table('tblinvoiceitems')
    ->where('tblinvoiceitems.id', $items['id'])
    ->where('tblinvoiceitems.relid', $items['relid'])
    ->join('tblpaymentgateways', function($join) {
        $join->on('tblinvoiceitems.paymentmethod', '=', 'tblpaymentgateways.gateway')
             ->where('tblpaymentgateways.setting', '=', 'name');
    })
    ->value('tblpaymentgateways.value');
}

$client_id = $clientsdetails['client_id'];


        
$customer_po = "";  
if($client_id){

    // $customer_po = Capsule::table('tblcustomfields')
    //     ->join('tblcustomfieldsvalues', 'tblcustomfields.id', '=', 'tblcustomfieldsvalues.fieldid')
    //     ->where('tblcustomfields.type', 'client')
    //     ->where('tblcustomfields.fieldtype', "text")
    //     ->where('tblcustomfields.fieldname', 'like', '%customer_po%')
    //     ->where('tblcustomfieldsvalues.relid', $client_id)
    //     ->value('value');

        $customer_po = Capsule::table('mod_w3_invoice_customer_po')->where('invoice_id', $invoicenum)->value('customer_po');
}

$tblhtml = '
<table style="border: 1px solid #828282; text-align:center; padding-top:5px;">
    <tr height="30" bgcolor="#efefef"> 
        <td height="20" style="background-color: #cdcdcd; border: 1px solid #828282;">Customer ID</td>
        <td height="20" style="background-color: #cdcdcd; border: 1px solid #828282;">Customer PO#</td>
        <td height="20" style="background-color: #cdcdcd; border: 1px solid #828282;">Payment Terms</td>
        <td height="20" style="background-color: #cdcdcd; border: 1px solid #828282;">Payment Mode</td>
        <td height="20" style="background-color: #cdcdcd; border: 1px solid #828282;">Currency</td>
    </tr>
    ';

$tblhtml .= '
    <tr bgcolor="#fff">
        <td height="20" style="border-right: 1px solid #828282;">'.$clientsdetails['client_id'].'</td>
        <td height="20" style="border-right: 1px solid #828282;">'.$customer_po.'</td>
        <td height="20" style="border-right: 1px solid #828282;">Immediate</td>
        <td height="20" style="border-right: 1px solid #828282;">'.$pay_type.'</td>
        <td height="20" style="border-right: 1px solid #828282;">'.$currency_code.'</td>
    </tr>
    </table>
    </div>';

$pdf->writeHTML($tblhtml, true, false, false, false, '');

$pdfContent = '';

// Loop through each line of the company address and add it to the variable
foreach ($companyaddress as $addressLine) {
    $pdfContent .= trim($addressLine) . "\n";
}

// Add the tax code if available
if ($taxCode) {
    $pdfContent .= $taxIdLabel . ': ' . trim($taxCode) . "\n";
}


# Invoice Items
$tblhtml = '<table width="100%" style="border: 1px solid #828282; text-align:center; padding-top:5px;">
    <tr height="30" bgcolor="#efefef" style="text-align:center;">
        <td width="30" style="background-color: #cdcdcd; border: 1px solid #828282;">#SNo</td>
        <td width="40" style="background-color: #cdcdcd; border: 1px solid #828282;">Product Code</td>
        <td width="180" style="background-color: #cdcdcd; border: 1px solid #828282;">' . Lang::trans('invoicesdescription') . '</td>
        <td width="40" style="background-color: #cdcdcd; border: 1px solid #828282;">Duration</td>
        <td width="40" style="background-color: #cdcdcd; border: 1px solid #828282;">Quantity</td>
        <td width="60" style="background-color: #cdcdcd; border: 1px solid #828282;">Unit Price</td>
        <td width="40" style="background-color: #cdcdcd; border: 1px solid #828282;">Discount</td>
        <td width="80" style="background-color: #cdcdcd; border: 1px solid #828282;">Amount</td>
    </tr>';

    $cusInvoiceItemsData = [];

    foreach ($invoiceitems as $item) {
        $duartion  = extractDuration($item['description']); 

        // Fetch client and currency information
        $getUserData = Capsule::table('tblinvoiceitems')
        ->leftJoin('tblclients', 'tblclients.id', '=', 'tblinvoiceitems.userid')
        ->join('tblcurrencies', 'tblcurrencies.id', '=', 'tblclients.currency')
        ->where('tblinvoiceitems.id', $item['id'])
        ->select('tblclients.currency', 'tblcurrencies.code')
        ->first();

    if (!$getUserData) {
        continue; // Skip if no client or currency data found
    }

    // Fetch addon pricing if needed
    $addonPricing = Capsule::table('tblpricing')
        ->where('currency', $getUserData->currency)
        ->where('type', 'domainaddons')
        ->select('msetupfee', 'qsetupfee', 'ssetupfee')
        ->first();

    // Process Hosting type items
    if ($item['type'] === 'Hosting') {

        $duartion  = extractDuration($item['description']); 
        $getDomainName = Capsule::table('tblhosting')->where('id', $item['relid'])->value('domain');

        $description = (!empty($getDomainName) ? '<span style="font-size: 10px; font-weight: bold; text-align: justify;">' . htmlspecialchars($getDomainName) . '</span><br>' 
        : '') . '<span style="text-align: start;">' . htmlspecialchars($item['description']) .'</span>';
        $cusInvoiceItemsData[] = [
            'id' => $item['id'],
            'type' => $item['type'],
            'relid' => $item['relid'],
            'description' => $description,
            'rawamount' => $item['rawamount'],
            'amount' => $item['amount'],
            'taxed' => $item['taxed'],
            'duration' => $duration,
            'Quantity' => $qty
        ];
        continue;
    }

    // Process DomainRegister type items
    if ($item['type'] === 'DomainRegister') {
        
        $duartion  = extractDuration($item['description']); 
        $description = str_replace('<br />', '', $item['description']);
        $descriptionParts = array_filter(array_map('trim', explode('+', $description)));

        foreach ($descriptionParts as $value) {
            preg_match_all('/\.\w+/', $value, $matches);
            $domainArray = $matches[0] ?? [];

            $tldIdRelid = Capsule::table('tbldomainpricing')
                ->whereIn('extension', $domainArray)
                ->value('id');

            $tldPrice = Capsule::table('tblpricing')
                ->where('type', 'domainregister')
                ->where('currency', $getUserData->currency)
                ->where('relid', $tldIdRelid)
                ->value('msetupfee');

            $getDomainName = Capsule::table('tbldomains')->where('id', $item['relid'])->value('domain');

            if (in_array($value, ["DNS Management", "Email Forwarding", "ID Protection"], true)) {
                $value = $value . (!empty($getDomainName) ? ' - ' . htmlspecialchars($getDomainName) : '');
                $item['amount'] = '-';
            }
            // if ($descriptionParts[0] === $value) {
            //     $item['amount'] = $tldPrice ?? $item['amount'];
            // } elseif ($value === "DNS Management") {
            //     $item['amount'] = $addonPricing->msetupfee ?? $item['amount'];
            //     $value = (!empty($getDomainName) ? 
            //         '<span style="font-size: 10px; font-weight: bold; text-align: justify;">' . htmlspecialchars($getDomainName) . '</span><br>' 
            //         : '') 
            //         . '<span style="text-align: left;">' . htmlspecialchars($value) . '</span>';
            // } elseif ($value === "Email Forwarding") {
            //     $item['amount'] = $addonPricing->qsetupfee ?? $item['amount'];
            //     $value = (!empty($getDomainName) ? 
            //     '<span style="font-size: 10px; font-weight: bold; text-align: justify;">' . htmlspecialchars($getDomainName) . '</span><br>' 
            //         : '') 
            //         . '<span style="text-align: left;">' . htmlspecialchars($value) . '</span>';
            // } elseif ($value === "ID Protection") {
            //     $item['amount'] = $addonPricing->ssetupfee ?? $item['amount'];
            //     $value = (!empty($getDomainName) ? 
            //     '<span style="font-size: 10px; font-weight: bold; text-align: justify;">' . htmlspecialchars($getDomainName) . '</span><br>' 
            //         : '') 
            //         . '<span style="text-align: left;">' . htmlspecialchars($value) . '</span>';
            // }
            
            $cusInvoiceItemsData[] = [
                'id' => $item['id'],
                'type' => $item['type'],
                'relid' => $item['relid'],
                'description' => $value,
                'rawamount' => $item['rawamount'],
                'amount' => $item['amount'],
                'taxed' => $item['taxed'],
                'duration' => $duration,
                'Quantity' => $qty
            ];
        }
        continue;
    }

    // For other item types
    $cusInvoiceItemsData[] = [
        'id' => $item['id'],
        'type' => $item['type'],
        'relid' => $item['relid'],
        'description' => trim($item['description']),
        'rawamount' => $item['rawamount'],
        'amount' => $item['amount'],
        'taxed' => $item['taxed'],
        'duration' => $duration,
        'Quantity' => $qty
    ];
}

// Fallback if no processed data
if(empty($cusInvoiceItemsData)){
    $cusInvoiceItemsData = $invoiceitems;
}
$invoiceitems = $cusInvoiceItemsData;

foreach ($invoiceitems as $index => $item) {
   
    // $duartion  = extractDuration($item['description']); 

    $details = Capsule::table('tblhosting')->where('id', $item['relid'])->first();

    if (strpos($item['description'], ' x ') !== false) {
        $qyt = explode('x', $item['description']);
        $qyt = trim($qyt[0]);
    } else {
        $qyt = 1;
    }    


    $tblhtml .= '
    <tr bgcolor="#fff">
        <td height="20px" style="border: 1px solid #828282;">' . ($index + 1) . '</td>
        <td height="20px" style="border: 1px solid #828282;">-</td>
        <td height="20px" style="border: 1px solid #828282;">' . nl2br($item['description']) . '</td>
        <td height="20px" style="border: 1px solid #828282;">'.$duartion.'</td>
        <td height="20px" style="border: 1px solid #828282;">'.$qyt.'</td>
        <td height="20px" style="border: 1px solid #828282; text-align:center;">'.$item['amount'].'</td>
        <td height="20px" style="border: 1px solid #828282;">-</td>
        <td height="20px" align="right" style="border: 1px solid #828282;">' . $item['amount'] . '</td>
    </tr>';
}


// Close the main items table
$tblhtml .= '</table>';

// Account information and invoice summary
$tblhtml .= '
<table style="width: 100%;">
    <tr height="20px">
        <td height="20px" style="width: 40%; line-height: 12px; font-size:7px;"><br/>
           <br/>' .nl2br($pdfContent) . '
        </td>
        <td height="20px"style="width: 60%; padding: 15px;">
            <table style="width: 100%; border: 0px solid #828282;">';

// Invoice summary rows
$tblhtml .= '
    <tr height="30px">
        <td height="20px" colspan="2" align="left" style="padding-top: 10px;padding-bottom: 10px;padding-left: 10px;padding-right: 10px; line-height: 20px; border: 0px solid #828282;">Subtotal</td>
        <td height="20px" width="100px" align="right" style="padding: 10px; line-height: 20px; border: 0px solid #828282;">' . $subtotal . '</td>
    </tr>
     <tr height="30px">
        <td height="20px" colspan="2" align="left" style="padding-top: 10px;padding-bottom: 10px;padding-left: 10px;padding-right: 10px; line-height: 20px; border: 0px solid #828282;">Total Invoice Amount</td>
        <td height="20px" width="100px" align="right" style="padding: 10px; line-height: 20px; border: 0px solid #828282;">' . $subtotal . '</td>
    </tr>
    ';
    

if ($taxname) {
    $tblhtml .= '
    <tr height="30px">
        <td height="20px" colspan="2" align="left" style="padding: 15px; line-height: 20px; border: 0px solid #828282;">' . $taxrate . '% ' . $taxname . '</td>
        <td height="20px" width="100px" align="right" style="padding: 15px; line-height: 20px; border: 0px solid #828282;">' . $tax . '</td>
    </tr>';
}

if ($taxname2) {
    $tblhtml .= '
    <tr height="30px">
        <td height="20px" colspan="2" align="left" style="padding: 15px; line-height: 20px; border: 0px solid #828282;">' . $taxrate2 . '% ' . $taxname2 . '</td>
        <td height="20px" align="right" style="padding: 15px; line-height:20px ; border-right: 0px solid #828282;">' . $tax2 . '</td>
    </tr>';
}

$tblhtml .= '
    <tr height="30px">
        <td height="20px" colspan="2" align="left" style="padding: 15px; line-height: 20px; border: 0px solid #828282;">Payment/Credit Applied</td>
        <td height="20px" align="right" style="padding: 15px; line-height: 20px; border-right: 0px solid #828282;">' . $credit . '</td>
    </tr>
    <tr height="30px">
        <td height="20px" colspan="2" align="left" style="padding: 15px; line-height: 20px; border: 0px solid #828282;"><p style="padding-top: 15px;">' . Lang::trans('invoicestotal') . '</p></td>
        <td height="20px" align="right" style="padding: 15px; line-height: 20px; border: 0px solid #828282;">' . $total . '</td>
    </tr>
</table>
        </td>
    </tr>
</table>';

$tblhtml .='
<table width="100%" style="border: 1px solid #828282; text-align:center; padding-top:5px;">
    <tr height="30" bgcolor="#efefef">
        <td width="25%" height="20" style="background-color: #cdcdcd; border: 1px solid #828282;">' . Lang::trans('invoicestransdate') . '</td>
        <td width="25%" height="20" style="background-color: #cdcdcd; border: 1px solid #828282;">' . Lang::trans('invoicestransgateway') . '</td>
        <td width="30%" height="20" style="background-color: #cdcdcd; border: 1px solid #828282;">' . Lang::trans('invoicestransid') . '</td>
        <td width="20%" height="20" style="background-color: #cdcdcd; border: 1px solid #828282;">' . Lang::trans('invoicestransamount') . '</td>
    </tr>';

if (!count($transactions)) {
    $tblhtml .= '
    <tr bgcolor="#fff">
        <td colspan="4" height="20" align="center" style="border: 1px solid #828282;">' . Lang::trans('invoicestransnonefound') . '</td>
    </tr>';
} else {
    foreach ($transactions AS $trans) {
        $tblhtml .= '
        <tr bgcolor="#fff">
            <td align="center" height="20" style="border: 1px solid #828282;">' . $trans['date'] . '</td>
            <td align="center" height="20" style="border: 1px solid #828282;">' . $trans['gateway'] . '</td>
            <td align="center" height="20" style="border: 1px solid #828282;">' . $trans['transid'] . '</td>
            <td align="center" height="20" style="border: 1px solid #828282;">' . $trans['amount'] . '</td>
        </tr>';
    }
}
$tblhtml .= '
    <tr height="30" bgcolor="#efefef" style="font-weight:bold;">
        <td colspan="3" height="20" align="right" style="border: 1px solid #828282;">' . Lang::trans('invoicesbalance') . '</td>
        <td align="center" height="20" style="border: 1px solid #828282;">' . $balance . '</td>
    </tr>
</table>';

// $pdf->SetXY(0,0);
$pdf->writeHTML($tblhtml, true,false, false, false, '');

$pdf->Ln(5);



$logoFilename = 'placeholder.png';
if (file_exists(ROOTDIR . '/templates/w3infotech/images/w3stamp.png')) {
    $logoFilename = 'w3stamp.png';
} elseif (file_exists(ROOTDIR . '/templates/w3infotech/images/w3stamp.jpg')) {
    $logoFilename = 'w3stamp.jpg';
} elseif (file_exists(ROOTDIR . '/templates/w3infotech/images/w3stamp.jpeg')) {
    $logoFilename = 'w3stamp.jpeg';
}
$tblhtml = '
    <table style="width: 90%; border-collapse: collapse;">
    <tr>
        <td style="width: 15%; text-align: left;">
            <p>Sd/<br>Accountant :</p>
            <p></p>
        </td>
        <td style="width:25%; text-align: left;">
           <div class="stam_img" style="margin-left: 2px;">
            <img src="' . ROOTDIR . '/templates/w3infotech/images/' . $logoFilename . '" alt="Company Stamp" style="width: 90px;"></div> 
        </td>
        <td style="width: 50%; text-align: right;">
            <p>Received By:</p>
            <p></p>
        </td>
    </tr>
</table>';
$pdf->writeHTML($tblhtml, true,false, false, false, '');


# footer logo
$logoFilename = 'placeholder.png';
if (file_exists(ROOTDIR . '/templates/w3infotech/images/logo_w3.png')) {
    $logoFilename = 'logo_w3.png';
} elseif (file_exists(ROOTDIR . '/templates/w3infotech/images/logo_w3.jpg')) {
    $logoFilename = 'logo_w3.jpg';
} elseif (file_exists(ROOTDIR . '/templates/w3infotech/images/logo_w3.jpeg')) {
    $logoFilename = 'logo_w3.jpeg';
}

$pdf->Ln(10);

$tblhtml = '
    <table style="width: 100%; border-collapse: collapse; text-align: center; font-family: Arial, sans-serif;">
    <tr>
        <td colspan="2" style="font-style: italic; color: gray; font-size:8px;">
            This is a computer generated invoice and no signature is required.
            <p style="border: none; border-top: 1px solid #3d8edf;"></p>
        </td>
    </tr>
    <tr>
        <td style="width: 70%; text-align: left;">
            <strong style="color:#205873; font-size:15px;">ROUTEDGE <span style="color:#205873; font-size:6px;">W.L.L</span> </strong>
            <p style="font-size:7px; font-family: Courier New, Courier, monospace; color:#156ab0;">
            PO Box: 31496, Doha, State of Qatar <br>
            Tel: +974-4434-3721, +974-4443-31-22 Fax: +974-444-12-731 Sales & Support: +974-66-703-103 <br>
            Email: info@routedge.com | www.routedge.com</p>
            <strong style="color:#2f3193;">Domain Registration Portal:</strong> <a href="http://www.routedge.net.qa" target="_blank" style="text-decoration: none; color:#2f3193;">www.routedge.net.qa</a>
        </td>
        <td style="width: 30%; text-align: center;">
            <center><img src="' . ROOTDIR . '/templates/w3infotech/images/' . $logoFilename . '" alt="Company Logo" style="width: 80px;"></center>
            <p style="color:#2d2859;"><b>Brandable Domains Forever!</b></p>
        </td>
    </tr>
</table>
<table>
<tr>
        <td>
            <img src="' . ROOTDIR . '/templates/w3infotech/images/header_line.png" alt="Border" style="width: auto; height: auto; display: block;">
        </td>
    </tr>
</table>
';
$pdf->writeHTML($tblhtml, true,false, false, false, '');




