<?php
require_once '../../../../../../init.php';

use WHMCS\Database\Capsule;

use WHMCS\Module\Addon\ManageDns\Helper;

$helper = new Helper();

$authid = $helper->getManageDnsData('authid');

$authpassword = urlencode($helper->getManageDnsData('password'));

$action = $whmcs->get_req_var('action');

$deleteaction = $whmcs->get_req_var('deleteaction');

$updateaction = $whmcs->get_req_var('updateaction');

$addtxtaction = $whmcs->get_req_var('addtxtaction');

$updatetxtaction = $whmcs->get_req_var('updatetxtaction');

$deletetxtaction = $whmcs->get_req_var('deletetxtaction');

$fetchaction = $whmcs->get_req_var('fetchaction');

$addmxaction = $whmcs->get_req_var('addmxaction');

$updatemxaction = $whmcs->get_req_var('updatemxaction');

$deletemxaction = $whmcs->get_req_var('deletemxaction');

$addcnameaction = $whmcs->get_req_var('addcnameaction');

$updatecnameaction = $whmcs->get_req_var('updatecnameaction');

$deletecnameaction = $whmcs->get_req_var('deletecnameaction');

$addspfeaction = $whmcs->get_req_var('addspfeaction');

$deletespfaction = $whmcs->get_req_var('deletespfaction');

$updatespfaction = $whmcs->get_req_var('updatespfaction');

$addsrveaction = $whmcs->get_req_var('addsrveaction');

$updatesrveaction = $whmcs->get_req_var('updatesrveaction');

$deletesrvcaction = $whmcs->get_req_var('deletesrvcaction');




if (!empty($action) && $action == 'addARecords') {

    $hostname = $whmcs->get_req_var('arecordhostname');
    $ipAddress = $whmcs->get_req_var('arecordipAddress');
    $ttl = $whmcs->get_req_var('arecordttl');
    $domainname = $whmcs->get_req_var('domainname');





    $url = "https://api.cloudns.net/dns/add-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-type=A&host=$hostname&record=$ipAddress&ttl=$ttl";



    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }
}

if (!empty($deleteaction) && $deleteaction == 'deleteARecords') {

   
    $domainname = $whmcs->get_req_var('deletedomainname');

    $recordid = $whmcs->get_req_var('deleterecotrdid');

    $url = "https://api.cloudns.net/dns/delete-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid";


    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }

}
if (!empty($updateaction) && $updateaction == 'updateARecords') {

   
    $hostname = $whmcs->get_req_var('updatearecordhostname');
    $ipAddress = $whmcs->get_req_var('updatearecordipAddress');
  
    $domainname = $whmcs->get_req_var('updatedomainname');

    $recordid = $whmcs->get_req_var('updaterecotrdid');
    $recordttl = $whmcs->get_req_var('recordttl');


    $url = "https://api.cloudns.net/dns/mod-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid&ttl=$recordttl&host=$hostname&record=$ipAddress";

    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }

}

if (!empty($addtxtaction) && $addtxtaction == 'addtxtRecords') {

   
    $hostname = $whmcs->get_req_var('addtxthostname');
    $ipAddress = $whmcs->get_req_var('addtxtipAddress');
  
    $domainname = $whmcs->get_req_var('addtxtdomainname');

    $recordttl = $whmcs->get_req_var('addtxtttl');


    $url = "https://api.cloudns.net/dns/add-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-type=TXT&ttl=$recordttl&host=$hostname&record=$ipAddress";

    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    
    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }

}


if (!empty($updatetxtaction) && $updatetxtaction == 'updatetxtRecords') {

   
    $hostname = $whmcs->get_req_var('updatetxtrecordhostname');
    $ipAddress = $whmcs->get_req_var('updatetxtrecordipAddress');
  
    $domainname = $whmcs->get_req_var('updatetxtdomainname');

    $recordid = $whmcs->get_req_var('updatetxtrecotrdid');
    $recordttl = $whmcs->get_req_var('recordtxtttl');


    $url = "https://api.cloudns.net/dns/mod-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid&ttl=$recordttl&host=$hostname&record=$ipAddress";

    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }

}

if (!empty($deletetxtaction) && $deletetxtaction == 'deletetxtRecords') {

   
    $domainname = $whmcs->get_req_var('deletetxtdomainname');

    $recordid = $whmcs->get_req_var('deletetxtrecotrdid');

    $url = "https://api.cloudns.net/dns/delete-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid";


    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }

}


if (!empty($fetchaction) && $fetchaction == 'fetchARecords') {

    $domainname = $whmcs->get_req_var('fetchdomainname');

    $url = "https://api.cloudns.net/dns/records.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname";

    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "GET");

    // Check if $result is an array and JSON-encode it for the JavaScript response
    if (is_array($result)) {
        $Success = [
            "status" => true,
            "message" => "Records fetched successfully",
            "data" => $result
        ];
        echo json_encode($Success);
    } else {
        $Error = [
            "status" => false,
            "message" => "Failed to fetch records.",
            "error" => "Unexpected data format received."
        ];
        echo json_encode($Error);
    }
    die;
}

if (!empty($addmxaction) && $addmxaction == 'addmxRecords') {

    $hostname = $whmcs->get_req_var('addmxhostname');
    $addmxipAddress = $whmcs->get_req_var('arecordipAddress');
    $ttl = $whmcs->get_req_var('addmxttl');
    $domainname = $whmcs->get_req_var('addmxdomainname');
    $priority = $whmcs->get_req_var('addpriority');


    $url = "https://api.cloudns.net/dns/add-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-type=MX&host=$hostname&record=$addmxipAddress&ttl=$ttl&priority=$priority";



    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }
}

if (!empty($updatemxaction) && $updatemxaction == 'updatemxRecords') {

   
    $hostname = $whmcs->get_req_var('updatemxrecordhostname');
    $ipAddress = $whmcs->get_req_var('updatemxrecordipAddress');
  
    $domainname = $whmcs->get_req_var('updatemxdomainname');

    $recordid = $whmcs->get_req_var('updatemxrecotrdid');
    $recordttl = $whmcs->get_req_var('recordmxttl');
    $priority = $whmcs->get_req_var('recordmxpriority');


    $url = "https://api.cloudns.net/dns/mod-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid&ttl=$recordttl&host=$hostname&record=$ipAddress&priority=$priority";

    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }
    else{

        $failed = ["status" => false, "message" => $result['statusDescription']];
        echo json_encode($failed);
        die;
    }

}


if (!empty($deletemxaction) && $deletemxaction == 'deletemxRecords') {

   
    $domainname = $whmcs->get_req_var('deletemxdomainname');

    $recordid = $whmcs->get_req_var('deletemxrecotrdid');

    $url = "https://api.cloudns.net/dns/delete-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid";


    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }

}

if (!empty($addcnameaction) && $addcnameaction == 'addcnameRecords') {

    $hostname = $whmcs->get_req_var('addcnamerecordhostname');
    $ipAddress = $whmcs->get_req_var('addcnamerecordipAddress');
    $ttl = $whmcs->get_req_var('addcnamerecordttl');
    $domainname = $whmcs->get_req_var('addcnamedomainname');





    $url = "https://api.cloudns.net/dns/add-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-type=CNAME&host=$hostname&record=$ipAddress&ttl=$ttl";



    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }
}

if (!empty($updatecnameaction) && $updatecnameaction == 'updatecnameRecords') {

   
    $hostname = $whmcs->get_req_var('updatespfrecordhostname');
    $ipAddress = $whmcs->get_req_var('updatespfrecordipAddress');
  
    $domainname = $whmcs->get_req_var('updatespfdomainname');

    $recordid = $whmcs->get_req_var('updatespfrecotrdid');
    $recordttl = $whmcs->get_req_var('recordspfttl');


    $url = "https://api.cloudns.net/dns/mod-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid&ttl=$recordttl&host=$hostname&record=$ipAddress";

    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }
    else{

        $failed = ["status" => false, "message" => $result['statusDescription']];
        echo json_encode($failed);
        die;
    }

}


if (!empty($deletecnameaction) && $deletecnameaction == 'deletecnameRecords') {

   
    $domainname = $whmcs->get_req_var('deletecnamedomainname');

    $recordid = $whmcs->get_req_var('deletecnamerecotrdid');

    $url = "https://api.cloudns.net/dns/delete-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid";


    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }

}


if (!empty($addspfeaction) && $addspfeaction == 'addspfeRecords') {

    $hostname = $whmcs->get_req_var('addspferecordhostname');
    $ipAddress = $whmcs->get_req_var('addspferecordipAddress');
    $ttl = $whmcs->get_req_var('addspfrecordttl');
    $domainname = $whmcs->get_req_var('addspfedomainname');





    $url = "https://api.cloudns.net/dns/add-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-type=SPF&host=$hostname&record=$ipAddress&ttl=$ttl";



    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }
    else {
        $failed = ["status" => false, "message" => $result['statusDescription']];
        echo json_encode($failed);
        die;
    }
}

if (!empty($deletespfaction) && $deletespfaction == 'deletespfRecords') {

   
    $domainname = $whmcs->get_req_var('deletespfdomainname');

    $recordid = $whmcs->get_req_var('deletespfrecotrdid');

    $url = "https://api.cloudns.net/dns/delete-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid";


    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }

}

if (!empty($updatespfaction) && $updatespfaction == 'updatespfRecords') {

   
    $hostname = $whmcs->get_req_var('updatecnamerecordhostname');
    $ipAddress = $whmcs->get_req_var('updatecnamerecordipAddress');
  
    $domainname = $whmcs->get_req_var('updatecnamedomainname');

    $recordid = $whmcs->get_req_var('updatecnamerecotrdid');
    $recordttl = $whmcs->get_req_var('recordcnamettl');


    $url = "https://api.cloudns.net/dns/mod-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid&ttl=$recordttl&host=$hostname&record=$ipAddress";

    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }
    else{

        $failed = ["status" => false, "message" => $result['statusDescription']];
        echo json_encode($failed);
        die;
    }

}

if (!empty($addsrveaction) && $addsrveaction == 'addsrveRecords') {

    $hostname = $whmcs->get_req_var('addsrverecordhostname');
    $ipAddress = $whmcs->get_req_var('addsrverecordrecord');
    $ttl = $whmcs->get_req_var('addsrvrecordttl');
    $weight = $whmcs->get_req_var('addsrveweight');
    $port = $whmcs->get_req_var('addsrveport');
    $priority = $whmcs->get_req_var('addsrvepriority');
    $domainname = $whmcs->get_req_var('addsrvdomainname');





    $url = "https://api.cloudns.net/dns/add-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-type=SRV&host=$hostname&record=$ipAddress&ttl=$ttl&priority=$priority&weight=$weight&port=$port";


    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }
    else {
        $failed = ["status" => false, "message" => $result['statusDescription']];
        echo json_encode($failed);
        die;
    }
}

if (!empty($updatesrveaction) && $updatesrveaction == 'updatesrveRecords') {

    $hostname = $whmcs->get_req_var('updatesrverecordhostname');
    $ipAddress = $whmcs->get_req_var('updatesrverecordrecord');
    $ttl = $whmcs->get_req_var('updatesrvrecordttl');
    $weight = $whmcs->get_req_var('updatesrveweight');
    $port = $whmcs->get_req_var('updatesrveport');
    $priority = $whmcs->get_req_var('updatesrvepriority');
    $domainname = $whmcs->get_req_var('updatesrvdomainname');
    $recordid = $whmcs->get_req_var('updatesrvrecordid');





    $url = "https://api.cloudns.net/dns/mod-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&host=$hostname&record=$ipAddress&priority=$priority&weight=$weight&port=$port&record-id=$recordid&ttl=$ttl";

    
    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }
    else {
        $failed = ["status" => false, "message" => $result['statusDescription']];
        echo json_encode($failed);
        die;
    }
}


if (!empty($deletesrvcaction) && $deletesrvcaction == 'deletesrvcRecords') {

    $domainname = $whmcs->get_req_var('deletesrvcdomainname');

    $recordid = $whmcs->get_req_var('deletesrvcrecotrdid');

    $url = "https://api.cloudns.net/dns/delete-record.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname&record-id=$recordid";


    $header = [];
    $data = null;

    $result = $helper->curlCall($header, $data, $url, "POST");


    if ($result['status'] == 'Success') {
        $Success = ["status" => true, "message" => $result['statusDescription']];
        echo json_encode($Success);
        die;
    }

}