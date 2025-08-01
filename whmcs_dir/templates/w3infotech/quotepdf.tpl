<?php

# Logo
if (file_exists(ROOTDIR.'/assets/img/logo.png')) $pdf->Image(ROOTDIR.'/assets/img/logo.png', 20, 25, 75);
elseif (file_exists(ROOTDIR.'/assets/img/logo.jpg')) $pdf->Image(ROOTDIR.'/assets/img/logo.jpg', 20, 25, 75);
elseif (file_exists(ROOTDIR.'/assets/img/logo.jpeg')) $pdf->Image(ROOTDIR.'/assets/img/logo.jpeg', 20, 25, 75);
else $pdf->Image(ROOTDIR.'/assets/img/placeholder.png', 20, 25, 75);

# Company Details
$pdf->SetFont($pdfFont,'',13);
$pdf->Cell(0,6,trim($companyaddress[0]),0,1,'R');
$pdf->SetFont($pdfFont,'',9);
for ( $i = 1; $i <= ((count($companyaddress)>6) ? count($companyaddress) : 6); $i += 1) {
    $pdf->Cell(0, 4, trim($companyaddress[$i] ?? ''), 0, 1, 'R');
}
$pdf->Ln(5);

$pdf->SetFont($pdfFont,'B',10);

$tblhtml = "
<table width=\"100%\" bgcolor=\"#ccc\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">
    <tr height=\"30\" bgcolor=\"#efefef\" style=\"font-weight:bold;text-align:center;\">
        <td>{$_LANG['quotenumber']}</td>
        <td>{$_LANG['quotesubject']}</td>
        <td>{$_LANG['quotedatecreated']}</td>
        <td>{$_LANG['quotevaliduntil']}</td>
    </tr>
    <tr bgcolor=\"#fff\">
        <td align=\"center\">{$quotenumber}</td>
        <td align=\"left\">{$subject}</td>
        <td align=\"center\">{$datecreated}</td>
        <td align=\"center\">{$validuntil}</td>
    </tr>
</table>";
$pdf->writeHTML($tblhtml, true, false, false, false, '');

$pdf->Ln(10);

$pdf->SetFont($pdfFont,'B',10);
$pdf->Cell(0,4,$_LANG['quoterecipient'],0,1);
$pdf->SetFont($pdfFont,'',9);
if ($clientsdetails["companyname"]) {
    $pdf->Cell(0,4,$clientsdetails["companyname"],0,1,'L');
    $pdf->Cell(0,4,$_LANG["invoicesattn"].": ".$clientsdetails["firstname"]." ".$clientsdetails["lastname"],0,1,'L');
} else {
    $pdf->Cell(0,4,$clientsdetails["firstname"]." ".$clientsdetails["lastname"],0,1,'L');
}
$pdf->Cell(0,4,$clientsdetails["address1"],0,1,'L');
if ($clientsdetails["address2"]) {
    $pdf->Cell(0,4,$clientsdetails["address2"],0,1,'L');
}
$pdf->Cell(0,4,$clientsdetails["city"].', '.$clientsdetails["state"].', '.$clientsdetails["postcode"],0,1,'L');
$pdf->Cell(0,4,$clientsdetails["country"],0,1,'L');

$pdf->Ln(10);

if ($proposal) {
    $pdf->SetFont($pdfFont,'B',15);
    $pdf->MultiCell(170,5,$proposal, 0, 'C');
    $pdf->Ln(10);
}

$pdf->SetDrawColor(200);
$pdf->SetFillColor(239);

$pdf->SetFont($pdfFont,'',8);

$tblhtml = '<table width="100%" style="border: 1px solid #8eb3c6; text-align:center; padding-top:5px;">
    <tr height="40" bgcolor="#efefef" style="text-align:center;">
        <td width="30" height="20" style="background-color: #e2eed8; border: 1px solid #8eb3c6; font-weight: bold;">#SNo</td>
        <td width="250" height="20" style="background-color: #e2eed8; border: 1px solid #8eb3c6; font-weight: bold;">' . Lang::trans('invoicesdescription') . '</td>
        <td width="55" height="20" style="background-color: #e2eed8; border: 1px solid #8eb3c6; font-weight: bold;">Duration</td>
        <td width="50" height="20" style="background-color: #e2eed8; border: 1px solid #8eb3c6; font-weight: bold;">Qty</td>
        <td width="60" height="20" style="background-color: #e2eed8; border: 1px solid #8eb3c6; font-weight: bold;">Unit Price</td>
        <td width="60" height="20" style="background-color: #e2eed8; border: 1px solid #8eb3c6; font-weight: bold;">Total</td>
    </tr>';

foreach ($lineitems AS $index => $item) {
    $tblhtml .= '
    
            <tr>
                <td style="text-align: left; border: 1px solid #8eb3c6;">'.($index + 1).'</td>
                <td style="text-align: left; border: 1px solid #8eb3c6;">'.nl2br($item['description']).'<br /></td>
                <td style="text-align: left; border: 1px solid #8eb3c6;">Yearly</td>
                <td style="text-align: left; border: 1px solid #8eb3c6;">'.$item['qty'].'</td>
                <td style="text-align: left; border: 1px solid #8eb3c6;">'.$item['unitprice'].'</td>
                <td style="text-align: left; border: 1px solid #8eb3c6;">'.$item['total'].'</td>
            </tr>
        ';
}
$tblhtml .= '
    <tr height="20" bgcolor="" style="font-weight:bold;">
        <td height="20" align="center" colspan="5" style="border: 1px solid #8eb3c6;">'.$_LANG['invoicessubtotal'].'</td>
        <td height="20" align="right" colspan="" style="border: 1px solid #8eb3c6;">'.$subtotal.'</td>
    </tr>';
if ($taxlevel1['rate']>0) $tblhtml .= '
    <tr height="20" bgcolor="" style="font-weight:bold;">
        <td height="20" align="right" colspan="5">'.$taxlevel1['name'].' @ '.$taxlevel1['rate'].'%</td>
        <td height="20" align="center">'.$tax1.'</td>
    </tr>';
if ($taxlevel2['rate']>0) $tblhtml .= '
    <tr height="20" bgcolor="" style="font-weight:bold;">
        <td height="20" align="right" colspan="5">'.$taxlevel2['name'].' @ '.$taxlevel2['rate'].'%</td>
        <td height="20" align="center">'.$tax2.'</td>
    </tr>';
$tblhtml .= '
    <tr height="20" bgcolor="" style="font-weight:bold;">
        <td height="20" align="center" colspan="5" style="border: 1px solid #8eb3c6;">'.$_LANG['invoicestotal'].'</td>
        <td height="20" align="center" style="border: 1px solid #8eb3c6;">'.$total.'</td>
    </tr>
    </table>';

$pdf->writeHTML($tblhtml, true, false, false, false, '');


$tblhtml = '
<table style="width: 100%; border-collapse: collapse; margin-bottom: 20px; padding-top:5px;">
        <tr>
            <th height="20" style="width: 50%; padding: 8px; text-align: left; border: 1px solid #8eb3c6; background-color: #d8e0f3;"><b>PAYMENT TERMS</b></th>
            <th height="20" style="width: 50%; padding: 8px; text-align: left; border: 1px solid #8eb3c6; background-color: #d8e0f3;"><b>DELIVERY TERMS</b></th>
        </tr>
        <tr>
            <td height="20" style="padding: 8px; text-align: left; border: 1px solid #8eb3c6;">100% advance payment with a firm Purchase Order</td>
            <td height="20" style="padding: 8px; text-align: left; border: 1px solid #8eb3c6;">As mutually agreed</td>
        </tr>
        <tr>
            <th height="20" style="padding: 8px; text-align: left; border: 1px solid #8eb3c6; background-color: #d8e0f3;"><b>VALIDITY</b></th>
            <th height="20" style="padding: 8px; text-align: left; border: 1px solid #8eb3c6; background-color: #d8e0f3;"></th>
        </tr>
        <tr>
            <td colspan="2" height="20" style="padding: 8px; text-align: left; border: 1px solid #8eb3c6;">The above offer is valid till 26 Aug 2024</td>
        </tr>
    </table>';
    $pdf->writeHTML($tblhtml, true, false, false, false, '');

$pdf->SetCellPadding(2);

$tblhtml = '
<table style="width: 100%; border-collapse: collapse; border: 1px solid #8eb3c6;">
<tr>
  <td height="20" style="text-align: left; border: 1px solid #8eb3c6; background-color: #e2eed8; padding:18px"><b>ORDER ACCEPTANCE</b></td>
  </tr>
  <tr>
    <td height="20">[  ]
    I Kiwi Digital solution by Checking the check boxes warrant that this is an e-agreement and I read and agree       
  </td>
</tr>
</table>';

    $pdf->writeHTML($tblhtml, true, false, false, false, '');





if ($notes) {
    $pdf->Ln(6);
    $pdf->SetFont($pdfFont,'',8);
    $pdf->MultiCell(170,5,$_LANG['invoicesnotes'].": $notes");
}
