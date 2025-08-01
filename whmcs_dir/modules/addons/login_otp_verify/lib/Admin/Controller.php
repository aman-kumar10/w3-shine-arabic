<?php
namespace WHMCS\Module\Addon\LoginOtpVerify\Admin;

use Exception;
use Smarty;
use WHMCS\Database\Capsule;
use WHMCS\Module\Addon\LoginOtpVerify\Helper;

class Controller {

    private $params = [];
    private $tplFileName;
    private $tplVar = array();

    public function __construct($params)
    {

        $helper =new Helper();

        global $CONFIG;

        $this->params = $params;

        $this->tplVar['rootURL'] = $CONFIG["SystemURL"];

        $this->tplVar['urlPath'] = $CONFIG["SystemURL"] . "/modules/addons/{$params['module']}/";

        $this->tplVar['moduleLink'] = $params['modulelink'];

        $this->tplVar['module'] = $params['module'];

        $this->tplVar['tplDIR'] = ROOTDIR . "/modules/addons/{$params['module']}/templates/admin/";

        $this->tplVar['header'] = ROOTDIR . "/modules/addons/{$params['module']}/templates/admin/include/header.tpl";

        $this->tplVar['footer'] = ROOTDIR . "/modules/addons/{$params['module']}/templates/admin/include/footer.tpl";

        $this->tplVar['cssPath'] = $CONFIG["SystemURL"]."/modules/addons/{$params['module']}/assets/css";

        $this->tplVar['asset']= $CONFIG["SystemURL"]."/modules/addons/{$params['module']}/assets";

    }



    public function dashboard()
    {
        try{
            global $whmcs;
            $helper =new Helper();

            if( !empty($whmcs->get_req_var('otpTemplate')) && !empty($whmcs->get_req_var('otpToken'))){
                $data['otpTemplate'] = $whmcs->get_req_var('otpTemplate');
                $data['otpToken'] = $whmcs->get_req_var('otpToken');
                $data['EmailOTP'] = (!empty($whmcs->get_req_var('EmailOTP')))?'on':'';
                $data['PhoneOTP'] = (!empty($whmcs->get_req_var('PhoneOTP')))?'on':'';

                foreach($data as $key => $value){
                    if(Capsule::table('mod_login_otp_setting')->where('name',$key)->value('id')){
                        Capsule::table('mod_login_otp_setting')->where('name',$key)->update(['value'=>$value]);
                    }else{
                        Capsule::table('mod_login_otp_setting')->insert([
                            'name'=>$key,
                            'value'=>$value
                        ]);
                    }
                }
                $this->tplVar['status'] = 'Your data is successfully Updated.';
            }
            
            $this->tplVar['getGeneralSettingData']=$helper->getGenralSetting();
            $this->tplVar['getEmailTemplate']=$helper->getCustomEmailTemplate();
            $this->tplFileName = $this->tplVar['tab'] = __FUNCTION__;
            $this->tplVar['dashboard'] ='active';
            $this->output();
        }catch(Exception $exception){
            logModuleCall("Login OTP Verification Module",'Admin Area', $exception->getMessage(),'');
            die('check addon module logs..');
        }
    }


    private function output()
    {
        $smarty = new Smarty();
        $smarty->assign('tplVar', $this->tplVar);
        if (!empty($this->tplFileName)) {
            $smarty->display($this->tplVar['tplDIR'] . $this->tplFileName . '.tpl');
        } else {
            $this->templateVar['errorMsg'] = 'not found';
        }
    }
}





