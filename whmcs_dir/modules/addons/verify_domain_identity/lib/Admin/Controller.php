<?php
namespace WHMCS\Module\Addon\verifyDomainIdentity\Admin;

use Exception;
use Smarty;
use WHMCS\Database\Capsule;
use WHMCS\Module\Addon\verifyDomainIdentity\Helper;

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

        $this->tplVar['header'] = ROOTDIR . "/modules/addons/{$params['module']}/templates/admin/header.tpl";

        $this->tplVar['footer'] = ROOTDIR . "/modules/addons/{$params['module']}/templates/admin/include/footer.tpl";

        $this->tplVar['cssPath'] = $CONFIG["SystemURL"]."/modules/addons/{$params['module']}/assets/css";

        $this->tplVar['asset']= $CONFIG["SystemURL"]."/modules/addons/{$params['module']}/assets";

    }



    public function dashboard()
    {
        try{
            global $whmcs;
            $helper = new Helper();
            $status = array();

            if($whmcs->get_req_var('type') == 'verify'){

                
                $command = 'DomainRegister';
                $postData = array(
                    'domainid' => $_POST['domainid'],
                );
                
                $results = localAPI($command, $postData);

                if ($results['result']=='error') {
                    $status = array("status"=>"Error","title"=>'Registrar Error Message',"message"=>$results['error'] );
                }
                
                if(!empty($whmcs->get_req_var('sendmail')) && !empty($whmcs->get_req_var('domainid'))){
                    $template_name = $helper->getTemplateName('verify_email_template');
                    $userid = Capsule::table('tbldomains')->where('id',$whmcs->get_req_var('domainid'))->value('userid');
                    $command = 'SendEmail';
                    $postData = array(
                        'messagename' => $template_name,
                        'id' => $whmcs->get_req_var('domainid'),
                    );
                    $results = localAPI($command, $postData);
                    if ($results['result']=='error') {
                        $status = array("status"=>"Error","title"=>'Send Email',"message"=>$results['message'] );
                    }
                }

                if($status['status']!='Error'){
                    $status = array("status"=>"success","title"=>'Success',"message"=>"Document is verified successfully" );
                    Capsule::table('mod_verify_domain_register')->where('domainid',$whmcs->get_req_var('domainid'))->update(['verify'=>1,"rejected"=>0]);
                }

            }else if($whmcs->get_req_var('type') == 'rejected'){

                if(!empty($whmcs->get_req_var('sendmail'))){
                    $template_name = $helper->getTemplateName('reject_email_template');
                    $userid = Capsule::table('tbldomains')->where('id',$whmcs->get_req_var('domainid'))->value('userid');
                    $reason =(!empty($whmcs->get_req_var('reason')))? $whmcs->get_req_var('reason') : '' ;

                    if($template_name && $userid){
                        $command = 'SendEmail';
                        $postData = array(
                            'messagename' => $template_name,
                            'id' => $whmcs->get_req_var('domainid'),
                            'customvars' => base64_encode(serialize(array("reject_reason"=> $reason))),
                        );
                        $results = localAPI($command, $postData);
    
                        if ($results['result']=='error') {
                            $status = array("status"=>"Error","title"=>'Send Email',"message"=>$results['message'] );
                        }
                    }

                }

                if($status['status']!='Error'){
                    $status = array("status"=>"success","title"=>'Success',"message"=>"Document is rejected successfully" );
                    Capsule::table('mod_verify_domain_register')->where('domainid',$whmcs->get_req_var('domainid'))->update(['verify'=>0,"rejected"=>1]);
                }
            }

            $this->tplVar['getRegisterDoamin'] = $helper->getDomain();
           

            $this->tplVar['status'] = $status;
            $this->tplFileName = $this->tplVar['tab'] = __FUNCTION__;
            $this->output();
        }catch(Exception $exception){
            logModuleCall("Login OTP Verification Module",'Admin Area', $exception->getMessage(),'');

            $this->tplVar['errormessage'] = $exception->getMessage();
            $this->tplFileName = $this->tplVar['tab'] = 'error';
            $this->output();

        }
    }

    public function change_registrar_details()
    {
        try{
            global $whmcs;
            $helper = new Helper();
            $status = array();

            if (isset($_POST) && !empty($_POST)) {
                if (isset($_POST["callFor"]) && $_POST["callFor"] == "get_domain_data") {
                    $domain_details = Capsule::table('mod_w3_change_contatcs_invoices')->where('domain_id',$_POST["domainId"])->first();
                    if(is_null($domain_details->value)){
                        $response = ["status" => "false", "message" => 'Data not found'];
                        echo json_encode($response);
                        die;
                    }else{
                        $response = ["status" => "success", "value" => $domain_details->value];
                        echo json_encode($response);
                        die;
                    }
                  
                }
            }

            $change_contact_details = Capsule::table('mod_w3_change_contatcs_invoices')->get();
            foreach($change_contact_details as $contact_details){
                if(!is_null($contact_details->value)){
                    $contact_details->details = json_decode($contact_details->value, true);
                }
                $contact_details->domain_name = Capsule::table('tbldomains')->where('id',$contact_details->domain_id)->value('domain');
                $contact_details->domain_status = Capsule::table('tbldomains')->where('id',$contact_details->domain_id)->value('status');
                $contact_details->user_name = Capsule::table('tblclients')->where('id',$contact_details->client_id)->value('firstname');
            }

            $this->tplVar['change_contact_details'] = $change_contact_details;
           

            $this->tplVar['status'] = $status;
            $this->tplFileName = $this->tplVar['tab'] = __FUNCTION__;
            $this->output();
        }catch(Exception $exception){
            logModuleCall("Login OTP Verification Module",'Admin Area', $exception->getMessage(),'');

            $this->tplVar['errormessage'] = $exception->getMessage();
            $this->tplFileName = $this->tplVar['tab'] = 'error';
            $this->output();

        }
    }


    public function Setting()
    {
        try{
            global $whmcs;
            $helper =new Helper();
            $status = '';

            if($whmcs->get_req_var('verify_email_template') && $whmcs->get_req_var('reject_email_template') ){
                $helper->updateEmailTemplate();
                $status = 'success';
            }

            $this->tplVar['status'] = $status;
            $this->tplVar['getDomainTemplate'] = $helper->getDomainTemplate();
            $this->tplVar['getSelectedEmailTemplate'] = $helper->getSelectedEmailTemplate();
            $this->tplFileName = $this->tplVar['tab'] = __FUNCTION__;
            $this->output();
        }catch(Exception $exception){
            logModuleCall("Login OTP Verification Module",'Admin Area', $exception->getMessage(),'');

            $this->tplVar['errormessage'] = $exception->getMessage();
            $this->tplFileName = $this->tplVar['tab'] = 'error';
            $this->output();

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





