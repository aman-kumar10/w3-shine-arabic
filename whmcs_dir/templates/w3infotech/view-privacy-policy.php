<?php
// Path to the PDF file
$pdfPath = __DIR__ . '/images/documents/privacy-policy.pdf';

if (file_exists($pdfPath)) {
    // Send headers to force browser to display the PDF
    header('Content-Type: application/pdf');
    header('Content-Disposition: inline; filename="privacy-policy.pdf"');
    readfile($pdfPath);
} else {
    echo "File not found.";
}
exit;