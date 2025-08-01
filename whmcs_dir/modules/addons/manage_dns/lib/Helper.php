<?php

namespace WHMCS\Module\Addon\ManageDns;

use WHMCS\Database\Capsule;


class Helper
{

    public function curlCall($header, $data, $url, $request)
    {
        $curl = curl_init();
        curl_setopt_array($curl, [
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => $request,
            CURLOPT_HTTPHEADER => $header ?: [],
        ]);

        if ($request === 'POST' || $request === 'PUT') {
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        }

        $response = curl_exec($curl);

        if (curl_errno($curl)) {
            $error = curl_error($curl);
            curl_close($curl);
            return ['error' => $error];
        }

        curl_close($curl);
        return json_decode($response, true);
    }

    public function getManageDnsData($name)
    {
        return Capsule::table('tbladdonmodules')->where('module', 'manage_dns')->where('setting', $name)->value('value');
    }


    public function getDomainData($id , $userid)
    {
        return Capsule::table('tbldomains')->where('id', $id)->where('userid' , $userid)->first();
    }
    public function CreateCustomTable()
    {
        if (!Capsule::schema()->hasTable('mod_dns_management')) {
            Capsule::schema()
                ->create(
                    'mod_dns_management',
                    function ($table) {
                        $table->increments('id');
                        $table->integer('userid');
                        $table->string('domianid');
                        $table->string('invoiceid');
                        $table->string('invoicestatus');
                        $table->string('dnsmanagement');
                    }
                );
        }
    }
    public function insertDomainData($userid, $domianid, $invoiceid, $invoicestatus, $dnsmanagement)
    {
        if (!Capsule::table('mod_dns_management')->where('domianid', $domianid)->value('id')) {
            return Capsule::table('mod_dns_management')->insert([
                "userid" => $userid,
                "domianid" => $domianid,
                "invoiceid" => $invoiceid,
                "invoicestatus" => $invoicestatus,
                "dnsmanagement" => $dnsmanagement
            ]);
        }
    }


    public function getCustromTableData($domianid , $userid)
    {
        return Capsule::table('mod_dns_management')->where('domianid', $domianid)->where('userid',$userid)->first();
    }

    function getDomainExtension($domain)
    {
        // Match the last two parts of the domain (e.g., .aaa.pro or .com)
        if (preg_match('/(\.[a-z0-9-]+\.[a-z]{2,}|(\.[a-z]{2,})+)$/i', $domain, $matches)) {
            return $matches[0];
        }
        return false; // Return false if no match is found
    }
    function CreateDomaindnsService($dominid ,$userid)
    {
        
        $zonetype = $this->getManageDnsData('zonetype');


        $authid = $this->getManageDnsData('authid');


        $authpassword = urlencode($this->getManageDnsData('password'));



        if ($dominid != "")
            $chekstus = $this->getCustromTableData($dominid , $userid);

        if ($chekstus->dnsmanagement == '1') {
            $domainname = $this->getDomainData($dominid , $userid);

            $url = "https://api.cloudns.net/dns/register.json?auth-id=$authid&auth-password=$authpassword&domain-name=$domainname->domain&zone-type=" . $zonetype;

            $header = [];

            $data = null;

            $result = $this->curlCall($header, $data, $url, "POST");

            if ($result['status'] == "Success") {

                $invoiceid = Capsule::table('tblinvoiceitems')->where('relid', $dominid)->value('invoiceid');

                Capsule::table('mod_dns_management')->where('invoiceid', $invoiceid)->update(['invoicestatus' => 'Paid']);

            } else {
                logModuleCall('manage dns addons', 'DomaindnsService', $url, '', $result['error']);
            }

            if (isset($result['error'])) {
                logModuleCall('manage dns addons', 'DomaindnsService', $url, '', $result['error']);
            } else {
                logModuleCall('manage dns addons', 'DomaindnsService', $url, '', $result);
            }
        }

    }
}