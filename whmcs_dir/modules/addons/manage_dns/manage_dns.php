<?php

use WHMCS\Database\Capsule;
use WHMCS\Module\Addon\ManageDns\Helper;
use WHMCS\Module\Addon\ManageDns\Admin\AdminDispatcher;
use WHMCS\Module\Addon\ManageDns\Client\ClientDispatcher;
if (!defined("WHMCS")) {
    die("This file cannot be accessed directly");
}

function manage_dns_config()
{
    return [

        'name' => 'Manage DNS',
        'description' => '',
        'author' => 'WHMCS Global Services',
        'language' => 'english',
        'version' => '1.0',
        'fields' => [
            'deleteDB' => [
                'FriendlyName' => 'Delete Database',
                'Type' => 'yesno',
                'Description' => 'Tick to enable'
            ],
            'authid' => [
                'FriendlyName' => 'Auth ID',
                'Type' => 'text',
                'Size' => '50',
                'Description' => 'Enter the DNS auth ID',
            ],
            'password' => [
                'FriendlyName' => 'Password',
                'Type' => 'password',
                'Size' => '25',
                'Default' => '',
                'Description' => 'Enter the DNS Password',
            ],
            'zonetype' => [
                'FriendlyName' => 'Zone Type',
                'Type' => 'dropdown',
                'Options' => [
                    'master' => 'Master',
                    'parked' => 'Parked',
                    'geodns' => 'Geodns',
                    'slave' => 'Slave',
                ],
                'Default' => 'master',
                'Description' => 'Enter the DNS Zone type',
            ],
        ]
    ];
}

function manage_dns_activate()
{
    try {

        if (!Capsule::schema()->hasTable('mod_manage_dns_setting')) {
            Capsule::schema()->create(
                'mod_manage_dns_setting',
                function ($table) {
                    $table->increments('id');
                    $table->string('setting');
                    $table->string('value');
                }
            );
        }
        if (!Capsule::schema()->hasTable('mod_manage_dns_zone_data')) {
            Capsule::schema()->create(
                'mod_manage_dns_zone_data',
                function ($table) {
                    $table->increments('id');
                    $table->string('domain_id');
                    $table->string('zone_type');
                }
            );
        }

        return [
            'status' => 'success',
            'description' => '',
        ];
    } catch (\Exception $e) {
        return [
            'status' => "error",
            'description' => 'Unable to create mod_verify_domain_register: ' . $e->getMessage(),
        ];
    }
}

function manage_dns_deactivate()
{

    if (Capsule::table('tbladdonmodules')->where('setting', 'deleteDB')->where('module', 'manage_dns')->where('value', 'on')->first()) {
        try {
            Capsule::schema()->dropIfExists('mod_manage_dns_setting');
        } catch (\Exception $e) {
            return [
                'status' => "error",
                'description' => 'Unable to create mod_verify_domain_register: ' . $e->getMessage(),
            ];
        }
    }
    return [

        'status' => 'success',
        'description' => '',
    ];
}

function manage_dns_output($vars)
{
    global $whmcs;
    $action = !empty($whmcs->get_req_var('action')) ? $whmcs->get_req_var('action') : 'dashboard';
    $dispatcher = new AdminDispatcher;
    $dispatcher->dispatch($action, $vars);
}

function manage_dns_clientarea($vars)
{

 
    // return array(
    //     'pagetitle' => 'client',
    //     'breadcrumb' => array('index.php?m=manage_dns' => 'manage_dns'),
    //     'templatefile' => 'client/email_otp_pages',
    //     'requirelogin' => true,
    //     'forcessl' => false,
    //     'vars' => array(
    //         'page_detail' => $vars,
    //         "error"=>$status,
    //         'extime' => $helper->expireTime(),
    //     ),

    // );

    
    $action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'manage_dns';

    $dispatcher = new ClientDispatcher();
    return $dispatcher->dispatch($action, $vars);
}   