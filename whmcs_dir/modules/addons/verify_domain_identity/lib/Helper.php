<?php 

    namespace WHMCS\Module\Addon\verifyDomainIdentity;

    use WHMCS\Database\Capsule;

    class Helper{

        public function getDomain(){

            $response = Capsule::table('mod_verify_domain_register')
            ->join('tbldomains', 'tbldomains.id','=','mod_verify_domain_register.domainid')
            ->select('tbldomains.*','mod_verify_domain_register.*')
            ->get();

            $responseData = array(); 
            foreach($response as $key=>$value){
                $value->registrationdate = fromMySQLDate($value->registrationdate);
                
                $value->files = array_map(function ($file) {
                    $parts = explode('-', $file, 3);
                    return [
                        'full_name' => $file,
                        'type' => $parts[1] ?? '', 
                    ];
                }, explode(',', $value->file));

                $responseData[] = $value;
            }

            return $responseData;
        }

        public function getDomainTemplate(){
            return Capsule::table('tblemailtemplates')->where('type','domain')->select('id', 'name')->get();
        }

        public function updateEmailTemplate(){
            global $whmcs;
            $update = [
                'verify_email_template' => (!empty($whmcs->get_req_var('verify_email_template'))) ? $whmcs->get_req_var('verify_email_template') : '' ,
                'reject_email_template' => (!empty($whmcs->get_req_var('reject_email_template'))) ? $whmcs->get_req_var('reject_email_template') : ''
            ];

            foreach($update as $key => $value){
                Capsule::table('mod_verify_domain_identity_setting')->where('setting',$key)->delete();
                Capsule::table('mod_verify_domain_identity_setting')->insert([
                    'setting' => $key,
                    'value' => $value
                ]);
            }
        }

        function CreateCustomfield()
        {
            try {
                $customfieldArry = array(
                    "0" => [
                        'type' => 'client',
                        'fieldtype' => 'text',
                        'relid' => '0',
                        'fieldname' => 'customer_po|Customer PO',
                        'description' => 'Customer PO',
                        'adminonly' => 'on',
                        'required' => '',
                        'showorder' => '',
                        'showinvoice' => '',
                    ],
                    "1" => [
                        'type' => 'client',
                        'fieldtype' => 'text',
                        'relid' => '0',
                        'fieldname' => 'gstin|GSTIN',
                        'description' => 'GSTIN',
                        'adminonly' => '',
                        'required' => '',
                        'showorder' => 'on',
                        'showinvoice' => '',
                    ],
                    "2" => [
                        'type' => 'client',
                        'fieldtype' => 'text',
                        'relid' => '0',
                        'fieldname' => 'fax|FAX',
                        'description' => 'FAX',
                        'adminonly' => '',
                        'required' => '',
                        'showorder' => 'on',
                        'showinvoice' => '',
                    ],
                );
        
                foreach ($customfieldArry as $clientdetail) {
                    $customfieldname = explode('|', $clientdetail['fieldname'])[0];
                    $checkcustomfieldvalueId = Capsule::table('tblcustomfields')->where('type', 'client')->where('fieldname', 'LIKE', '%' . $customfieldname . '%')->where('relid', '0')->count();
                    if ($checkcustomfieldvalueId == 0) {
                        $custom_field_id = Capsule::table('tblcustomfields')->insert($clientdetail);
                    }
                }

            } catch (Exception $e) {
                logModuleCall(
                    'provisioningmodule',
                    "create custom fields client side",
                    $e->getMessage(),
                );
                return [
                    'status' => "error",
                    'description' => 'Unable to : create customfields w3infotech' . $e->getMessage(),
                ];
            }
        }


        public function getSelectedEmailTemplate(){
            $response = Capsule::table('mod_verify_domain_identity_setting')->get();
            $responses = array();
            foreach($response as $key => $value){
                $responses [$value->setting]=$value->value;
            }
            return $responses;
        }

        public function getTemplateName($type){
           return  Capsule::table('mod_verify_domain_identity_setting')
                    ->join('tblemailtemplates','tblemailtemplates.id', 'mod_verify_domain_identity_setting.value')
                    ->where('mod_verify_domain_identity_setting.setting',$type)
                    ->value('tblemailtemplates.name');
        }

        
    }



