<?php
use WHMCS\Database\Capsule;



add_hook('ClientAreaPage', 1, function($vars) {

    if($_SERVER['SCRIPT_NAME'] == '/cart.php' && !isset($_SESSION['uid'])){
        $_SESSION['GOTO_REQUEST_URI'] = $_SERVER['REQUEST_URI'];
        header("Location: /index.php/login");
        exit();
    }

    if(isset($_SESSION['uid']) && $_SERVER['REQUEST_URI'] != '/index.php?m=login_otp_verify' && !isset($_SESSION['adminid']) && $_COOKIE['sendotp']=='rdEmail'){
        $userauth = Capsule::table('mod_client_verification_otp')->where('userid',$_SESSION['uid'])->where('status','Inactive')->first();
        $check_2fa = Capsule::table('tblusers')->where('id',$_SESSION['uid'])->where('second_factor','totp')->first();
        if(is_null($check_2fa) && $userauth){
            header("Location: /index.php?m=login_otp_verify");
            exit();
        }
    }
});

add_hook('ClientAreaPageLogin', 1, function($vars) {
    $extraVariables = [
        'emailotp' => Capsule::table('mod_login_otp_setting')->where('name','EmailOTP')->value('value'),
        'phoneotp' => Capsule::table('mod_login_otp_setting')->where('name','PhoneOTP')->value('value'),
    ];
    return $extraVariables;
});

add_hook('UserLogout', 1, function($vars) {
    Capsule::table('mod_client_verification_otp')->where('userid',$_SESSION['vu'])->update(['status'=>'Inactive']);
    unset($_SESSION['vu']);
});

add_hook('UserLogin', 999, function($vars) {
    try {

        $email_send = Capsule::table('mod_login_otp_setting')->where('name','EmailOTP')->value('value');
    
        if(isset($_SESSION['uid']) && $email_send=='on' && !isset($_SESSION['adminid']) && $_COOKIE['sendotp']=='rdEmail'){
    
            $check_2fa = Capsule::table('tblusers')->where('id',$_SESSION['uid'])->where('second_factor','totp')->first();
    
            if(is_null($check_2fa)){
    
                $otp = generateVerificationCodeSix();
                Capsule::table('mod_client_verification_otp')->where('userid', $_SESSION['uid'])->delete();
    
                Capsule::table('mod_client_verification_otp')->insert([
                    'userid' => $_SESSION['uid'],
                    'authcode'=> $otp,
                    'status' => 'Inactive',
                    'time' => time()
                ]);
        
                $templateid = Capsule::table('mod_login_otp_setting')->where('name','otpTemplate')->value('value');
                $templatename = Capsule::table('tblemailtemplates')->where('id',$templateid)->value('name');
                $extime = Capsule::table('mod_login_otp_setting')->where('name','otpToken')->value('value');
        
                sendOTPEmail($_SESSION['uid'], $otp, $templatename, $extime);
        
                if ($results['result']=='success') {
                    $_SESSION['vu'] = $_SESSION['uid'];
                    header("Location: /index.php?m=login_otp_verify");
                    exit();
                }
                
            }
      
        }

    } catch (Exception $e) {
        logActivity("Error in UserLogin hook, Error: ". $e->getMessage());
    }
       
});


// Generate verification code (OTP)
function generateVerificationCodeSix() {
    try {
        return str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);
    } catch (Exception $e) {
        logActivity("Unable to verification code (OTP)" . $e->getMessage());
    }
}

// Send email
function sendOTPEmail($id, $otp, $templatename, $expTime){
    try {
        $postData = [
            'messagename' => $templatename,
            'id' => $id,
            'customvars' => base64_encode(serialize([
                'verifyOTP' => $otp,
                'expTime' => $expTime,
            ])),
        ];

        localAPI('SendEmail', $postData);

    } catch (Exception $e) {
        logActivity("Unable to sent verification code(OTP) email" . $e->getMessage());
    }
}