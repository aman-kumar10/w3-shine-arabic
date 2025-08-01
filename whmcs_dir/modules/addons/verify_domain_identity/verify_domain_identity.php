<?php 

use WHMCS\Database\Capsule;
use WHMCS\Module\Addon\verifyDomainIdentity\Helper;
use WHMCS\Module\Addon\verifyDomainIdentity\Admin\AdminDispatcher;

if (!defined("WHMCS")) {
    die("This file cannot be accessed directly");
}

function verify_domain_identity_config()
{
    return [
        
        'name' => 'Verify Domain Identity',
        'description' => '',
        'author' => '',
        'language' => 'english',
        'version' => '1.0',
        'fields' => [
            'deleteDB' => [
                'FriendlyName' => 'Delete Database',
                'Type' => 'yesno',
                // 'Description'=> 'Send OTP to WHMCS Client',
            ], 
        ]
    ];
}

function verify_domain_identity_activate()
{
    try {
        $helper = new Helper();
        $helper->CreateCustomfield();

        if (!Capsule::schema()->hasTable('mod_verify_domain_register')) {
            Capsule::schema()->create(
                'mod_verify_domain_register',
                function ($table) {
                    $table->increments('id');
                    $table->integer('domainid');
                    $table->integer('verify');
                    $table->integer('rejected');
                    $table->string('company_document')->nullable();
                    $table->string('trade_mark')->nullable();
                    $table->string('expirey_date')->nullable();
                    $table->string('company_name')->nullable();
                    $table->string('file')->nullable();
                    $table->timestamp('created_at');
                    $table->timestamp('updated_at');
                }
            );
        }

        if (!Capsule::schema()->hasTable('mod_verify_domain_identity_setting')) {
            Capsule::schema()->create(
                'mod_verify_domain_identity_setting',
                function ($table) {
                    $table->increments('id');
                    $table->string('setting');
                    $table->string('value');
                }
            );
        }

        if (!Capsule::schema()->hasTable('mod_w3_domain_contact_details')) {
            Capsule::schema()->create(
                'mod_w3_domain_contact_details',
                function ($table) {
                    $table->increments('id');
                    $table->string('client_id');
                    $table->string('domain');
                    $table->string('registrant');
                    $table->string('technical');
                    $table->string('administrative');
                    $table->string('billing');
                    $table->timestamp('created_at');
                    $table->timestamp('updated_at');
                }
            );
        }

        if (!Capsule::schema()->hasTable('mod_w3_transfer_domain_details')) {
            Capsule::schema()->create(
                'mod_w3_transfer_domain_details',
                function ($table) {
                    $table->increments('id');
                    $table->string('client_id');
                    $table->string('domain');
                    $table->string('current_rigister');
                    $table->string('epp');
                    $table->string('domain_file');
                    $table->timestamp('created_at');
                    $table->timestamp('updated_at');
                }
            );
        }

        if (!Capsule::schema()->hasTable('mod_w3_change_contatcs_invoices')) {
            Capsule::schema()->create(
                'mod_w3_change_contatcs_invoices',
                function ($table) {
                    $table->increments('id');
                    $table->string('client_id');
                    $table->string('domain_id');
                    $table->string('invoice_id');
                    $table->integer('status')->default(0);
                    $table->longtext('value')->nullable();
                    $table->timestamp('created_at');
                    $table->timestamp('updated_at');
                }
            );
        }

        if (!Capsule::schema()->hasTable('mod_w3_invoice_customer_po')) {
            Capsule::schema()->create(
                'mod_w3_invoice_customer_po',
                function ($table) {
                    $table->increments('id');
                    $table->string('client_id');
                    $table->string('invoice_id');
                    $table->string('customer_po')->nullable();
                    $table->timestamp('created_at');
                    $table->timestamp('updated_at');
                }
            );
        }

        if (!Capsule::schema()->hasTable('mod_w3_registrar_agreement')) {
            Capsule::schema()->create(
                'mod_w3_registrar_agreement',
                function ($table) {
                    $table->increments('id');
                    $table->string('domain_id');
                    $table->text('document');
                    $table->timestamp('created_at');
                    $table->timestamp('updated_at');
                }
            );
        }

        if (!Capsule::schema()->hasTable('mod_w3_renew_domain_services')) {
            Capsule::schema()->create(
                'mod_w3_renew_domain_services',
                function ($table) {
                    $table->increments('id');
                    $table->integer('domain_id');
                    $table->integer('invoice_id');
                    $table->integer('status')->default(0);
                    $table->timestamp('created_at');
                    $table->timestamp('updated_at');
                }
            );
        }

        if (!Capsule::schema()->hasTable('mod_w3_domain_mangement_services')) {
            Capsule::schema()->create(
                'mod_w3_domain_mangement_services',
                function ($table) {
                    $table->increments('id');
                    $table->string('domain_name');
                    $table->integer('serviceid');
                    $table->integer('status')->default(0);
                    $table->timestamp('created_at');
                    $table->timestamp('updated_at');
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

function verify_domain_identity_deactivate()
{

        // if(Capsule::table('tbladdonmodules')->where('setting','deleteDB')->where('module','verify_domain_identity')->where('value','on')->first()){
        //     try {
        //         Capsule::schema()->dropIfExists('mod_verify_domain_identity_setting');
        //         Capsule::schema()->dropIfExists('mod_verify_domain_register');
        //     } catch (\Exception $e) {
        //         return [
        //             'status' => "error",
        //             'description' => 'Unable to create mod_verify_domain_register: ' . $e->getMessage(),
        //         ];
        //     }
        // }
        // return [
        //     'status' => 'success',
        //     'description' => '',
        // ];
}

function verify_domain_identity_output($vars)
{
    global $whmcs;
    $action = !empty($whmcs->get_req_var('action')) ? $whmcs->get_req_var('action') : 'dashboard';
    $dispatcher = new AdminDispatcher;
    $dispatcher->dispatch($action, $vars);
}

function verify_domain_identity_clientarea($vars)
{ 
            // return array(
            //     'pagetitle' => 'client',
            //     'breadcrumb' => array('index.php?m=verify_domain_identity' => 'verify_domain_identity'),
            //     'templatefile' => 'client/email_otp_pages',
            //     'requirelogin' => true,
            //     'forcessl' => false,
            //     'vars' => array(
            //         'page_detail' => $vars,
            //         "error"=>$status,
            //         'extime' => $helper->expireTime(),
            //     ),

            // );
}