<?php

namespace WHMCS\Module\Addon\ManageDns\Client;

use WHMCS\Module\Addon\ManageDns\Helper;

// use WHMCS\Module\Addon\domain_auction_badgs\Helper;
use WHMCS\Database\Capsule;
use Smarty;

class Controller
{
    

    public function manage_dns($vars)
    {


        global $CONFIG;

        $helper = new Helper();
        global $whmcs;

        $modulelink = $vars['modulelink'];
        $headrePath = ROOTDIR . '/modules/addons/manage_dns/templates/clients/header.tpl';



        $domainname = Capsule::table('tbldomains')->where('id', $whmcs->get_req_var('domain'))->where('userid', $_SESSION['uid'])->where('status', 'Active')->value('domain');


        $language = Capsule::table("tblclients")->where("id", $_SESSION["uid"])->value("language");
        if ($_SESSION["Language"] != "english" && isset($_SESSION["Language"])) {
            $language = $_SESSION["Language"];
        }
        $langfilename = dirname(dirname(__DIR__)) . '/lang/' . $language . '.php';
        if (file_exists($langfilename)) {
            require($langfilename);
        } else {
            require(dirname(dirname(__DIR__)) . '/lang/english.php');
        }
        $LANG = $_ADDONLANG;


        $authid = $helper->getManageDnsData('authid');

        $authpassword = urlencode($helper->getManageDnsData('password'));

        $url = "https://api.cloudns.net/dns/get-zone-info.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname";



        $header = [];
        $data = null;

        $domainstatus = $helper->curlCall($header, $data, $url, "GET");

        // echo "<pre>";
        // print_r($domainstatus);
        // die;

        return array(
            'pagetitle' => 'DNS Records',
            'breadcrumb' => array(
                $modulelink => 'managed_dns',
            ),
            'templatefile' => 'clients/managed_dns',
            'vars' => array(
                'modulelink' => $modulelink,
                "headerPath" => $headrePath,
                'domainname' => $domainname,
                'login' => $_SESSION['uid'],
                'systemurl' => $CONFIG['SystemURL'],
                "LANG_VAR" => $LANG,
                'domainstatus' => $domainstatus['status'],
                'customVariable' => 'your own content goes here',
            ),
        );

    }
}