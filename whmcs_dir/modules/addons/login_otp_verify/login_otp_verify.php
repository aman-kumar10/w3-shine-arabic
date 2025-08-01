<?php

use WHMCS\Database\Capsule;
use WHMCS\Module\Addon\LoginOtpVerify\Helper;
use WHMCS\Module\Addon\LoginOtpVerify\Admin\AdminDispatcher;

if (!defined("WHMCS")) {
    die("This file cannot be accessed directly");
}

function login_otp_verify_config()
{
    return [
        
        'name' => 'Login OTP Verification',
        'description' => 'This module is for sending a login OTP to WHMCS clients.',
        'author' => '<a href="http://whmcsglobalservices.com/" target="_blank">WHMCS GLOBAL SERVICES</a>',
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

function login_otp_verify_activate()
{
    try {
        if (!Capsule::schema()->hasTable('mod_client_verification_otp')) {
            Capsule::schema()->create(
                'mod_client_verification_otp',
                function ($table) {
                    $table->increments('id');
                    $table->integer('userid');
                    $table->string("authcode");
                    $table->string("time");
                    $table->enum('status', ['Inactive', 'Active'])->default('Inactive');
                }
            );
        }

        if (!Capsule::schema()->hasTable('mod_login_otp_setting')) {
            Capsule::schema()->create(
                'mod_login_otp_setting',
                function ($table) {
                    $table->increments('id');
                    $table->string('name');
                    $table->string("value");
                }
            );
        }

        if (!Capsule::table('tblemailtemplates')->where('type', 'user')->where('name', 'Login OTP Verification')->count()) {
                Capsule::table('tblemailtemplates')->insert([
                    'type' => 'user',
                    'name' => 'Login OTP Verification',
                    'subject' => 'Your Login Verification Code',
                    'message' => '
                        <p>Dear {$user_first_name} {$user_last_name},</p>

                        <p>We received a request to log in to your account. Please use the following One-Time Password (OTP) to complete your login:</p>

                        <p style="font-size: 20px; font-weight: bold; background-color: #f2f2f2; padding: 10px; border-radius: 5px; display: inline-block;">
                            {$verifyOTP}
                        </p>

                        <p>This OTP is valid for {$expTime} minutes and should not be shared with anyone.</p>

                        <p>If you did not initiate this login request, please ignore this message or contact our support team immediately.</p>

                        <p>Best regards,<br>The Support Team</p>
                    ',
                    'custom' => 1
                ]);
            }
        

        return [
            'status' => 'success',
            'description' => '',
        ];
    } catch (\Exception $e) {
        return [
            'status' => "error",
            'description' => 'Unable to create mod_client_verification_otp: ' . $e->getMessage(),
        ];
    }
}

function login_otp_verify_deactivate()
{

        if(Capsule::table('tbladdonmodules')->where('setting','deleteDB')->where('module','login_otp_verify')->where('value','on')->first()){
            try {
                Capsule::schema()->dropIfExists('mod_login_otp_setting');
                Capsule::schema()->dropIfExists('mod_client_verification_otp');
            } catch (\Exception $e) {
                return [
                    'status' => "error",
                    'description' => 'Unable to create mod_login_otp_setting: ' . $e->getMessage(),
                ];
            }
        }
        return [
           
            'status' => 'success',
            'description' => '',
        ];
}

function login_otp_verify_output($vars)
{
    global $whmcs;
    $action = !empty($whmcs->get_req_var('page')) ? $whmcs->get_req_var('page') : 'dashboard';
    $dispatcher = new AdminDispatcher;
    $dispatcher->dispatch($action, $vars);
}

function login_otp_verify_clientarea($vars)
{ 
    try{
        $helper = new Helper();
        global $whmcs;

        if(isset($_SESSION['uid'])){

            if(!empty($whmcs->get_req_var('validateotp')) ){
                $auth = Capsule::table('mod_client_verification_otp')->where('userid',$_SESSION['uid'])->where('authcode',$whmcs->get_req_var('validateotp'))->value('id');
                if($auth){
                    Capsule::table('mod_client_verification_otp')->where('id',$auth)->update(['status'=>'Active']);
                    $_SESSION['vu']=$_SESSION['uid'];
                    
                    if(isset($_SESSION['GOTO_REQUEST_URI'])){
                        $GOTO_REQUEST_URI = $_SESSION['GOTO_REQUEST_URI'];
                        unset($_SESSION['GOTO_REQUEST_URI']);
                        header("Location: $GOTO_REQUEST_URI");
                    }
                    else{
                        header("Location: /index.php");
                    }
                    exit();
                }else{
                    $status = 'Invalid OTP, Try Again';
                }
            }
            
            if(!empty($whmcs->get_req_var('action')) &&  $whmcs->get_req_var('action')=='resend_otp'){
                $helper->resendOtp();
            }

            return array(
                'pagetitle' => 'client',
                'breadcrumb' => array('index.php?m=login_otp_verify' => 'login_otp_verify'),
                'templatefile' => 'client/email_otp_pages',
                'requirelogin' => true,
                'forcessl' => false,
                'vars' => array(
                    'page_detail' => $vars,
                    "error"=>$status,
                    'extime' => $helper->expireTime(),
                ),

            );
        }
    }catch(Exception $exception){
        // logModuleCall("Login OTP Verification Module",'Client Area', $exception->getMessage(),'');
        unset($_SESSION['uid']);
        unset($_SESSION['login_auth_tk']);
        return array(
            'pagetitle' => 'error',
            'breadcrumb' => array('index.php?m=login_otp_verify' => 'login_otp_verify'),
            'templatefile' => 'client/error',
            'requirelogin' => false,
            'forcessl' => false,
            'vars' => array(
                'page_detail' => $vars,
                'back'=>'/index.php/login',
                'home'=>'/'
            ),

        );
    }
}