<?php

use WHMCS\Database\Capsule;

if ($_REQUEST['session_get']) {
    global $CONFIG;

    $systemURL = $CONFIG['SystemURL'];

    $getParentSession = $_SESSION['w3'];
   

    if (is_array($getParentSession)) {
        foreach ($getParentSession as $domain_name => $domain_file_list) {
            foreach ($domain_file_list['files'] as $domain_files) {
                if($domain_files['error'] == 0){
                    
                        print_r('<pre>');
                        print_r($domain_files);

                        $domain = str_replace('.','',$domain_name);
                        $tmpFilePath =$domain_files['tmp_name'];
                        $filename = $domain.'_'.$domain_files['file_name'].'.'.explode('/',$domain_files['type'])[1];

                        $targetFile = ROOTDIR.'/modules/addons/verify_domain_identity/uploadfile/'.$filename;
                        print($tmpFilePath);
                        print($targetFile);
                        
                        $response = move_uploaded_file($tmpFilePath, $targetFile);
                        print_r($response);
                        print('<hr>');
                }
            }
        }
    }
    die(); 
}

// $uploadsDir = ROOTDIR . "/modules/addons/{$this->params['module']}/Storage";


