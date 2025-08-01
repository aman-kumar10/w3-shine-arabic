<?php
namespace WHMCS\Module\Addon\ManageDns\Admin;

use Exception;
use Smarty;
use WHMCS\Database\Capsule;
use WHMCS\Module\Addon\ManageDns\Helper;

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





