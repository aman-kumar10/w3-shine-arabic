<?php 

    namespace WHMCS\Module\Addon\LoginOtpVerify;

    use WHMCS\Database\Capsule;

    class Helper{
        public function getCustomEmailTemplate(){
          $response =  Capsule::table('tblemailtemplates')->where('type', 'user')->where('name', 'Login OTP Verification')->where('custom','1')->select('id','name')->get();
          
          $responses = array();
          foreach($response as $value){
            $responses[$value->id]=$value->name;
          }
          return $responses;
        }

        public function getGenralSetting(){
            $response =  Capsule::table('mod_login_otp_setting')->get();
          
            $responses = array();
            foreach($response as $value){
              $responses[$value->name]=$value->value;
            }
            return $responses;
        }


        public function resendOtp(){
            $otp = random_int(100000, 999999);
        
            Capsule::table('mod_client_verification_otp')->where('userid',$_SESSION['uid'])->update(['authcode'=>$otp,'time'=>strtotime('now')]);
        
            $templateid = Capsule::table('mod_login_otp_setting')->where('name','otpTemplate')->value('value');

            $extime = Capsule::table('mod_login_otp_setting')->where('name','otpToken')->value('value');
            $templatename = Capsule::table('tblemailtemplates')->where('id',$templateid)->value('name');

            $command = 'SendEmail';
            $postData = array(
                'messagename' => $templatename,
                'id' => $_SESSION['uid'],
                'customvars' => base64_encode(serialize(array("otp"=>$otp,"extime"=>$extime))),
            );
            $results = localAPI($command, $postData);
            $token = Capsule::table('mod_login_otp_setting')->where('name','otpToken')->value('value');
        
            if ($results['result']=='success') {
                echo json_encode(['stutas'=>'success','message'=>'Resend OTP Successfully..','token'=>$token ]);
            }
            die();
        }

        public function expireTime(){
          $token = Capsule::table('mod_login_otp_setting')->where('name','otpToken')->value('value');
          $userTime = Capsule::table('mod_client_verification_otp')->where('userid',$_SESSION['uid'])->value('time');

          if(strtotime('now') < strtotime(Date('Y-m-d H:i:s',$userTime)."+ $token minute") && $userTime){
            $extime =   strtotime(Date('Y-m-d H:i:s',$userTime)."+ $token minute") - strtotime('now') ;
            return $extime;
          }else{
              $otp = random_int(100000, 999999);
              Capsule::table('mod_client_verification_otp')->where('userid',$_SESSION['uid'])->update(['authcode'=>$otp,'time'=>strtotime('now')]);

              $templateid = Capsule::table('mod_login_otp_setting')->where('name','otpTemplate')->value('value');
              $templatename = Capsule::table('tblemailtemplates')->where('id',$templateid)->value('name');
              $extime = Capsule::table('mod_login_otp_setting')->where('name','otpToken')->value('value');

              $command = 'SendEmail';
              $postData = array(
                  'messagename' => $templatename,
                  'id' => $_SESSION['uid'],
                  'customvars' => base64_encode(serialize(array("otp"=>$otp,"extime"=>$extime))),
              );
              $results = localAPI($command, $postData);

              $extime =   strtotime(Date('Y-m-d H:i:s',Capsule::table('mod_client_verification_otp')->where('userid',$_SESSION['uid'])->value('time'))."+ $token minute") - strtotime('now') ;
              return $extime;
            }
        }
    }



